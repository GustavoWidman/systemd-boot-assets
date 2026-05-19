{
  description = "Pinned systemd-boot EFI binaries built with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      release = import ./release.nix;
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
        isLinux = pkgs.stdenv.hostPlatform.isLinux;
        bootstrapFailure = pkgs.runCommand "systemd-boot-assets-bootstrap-error" { } ''
          printf '%s\n' "systemd-boot-assets has no published release metadata yet; run the release workflow first" >&2
          exit 1
        '';
        bundleAsset = if release.bootstrap then bootstrapFailure else pkgs.fetchurl {
          url = release.assets.bundle.url;
          hash = release.assets.bundle.hash;
          name = release.assets.bundle.file;
        };
        x64Asset = if release.bootstrap then bootstrapFailure else pkgs.fetchurl {
          url = release.assets.x64.url;
          hash = release.assets.x64.hash;
          name = release.assets.x64.file;
        };
        aa64Asset = if release.bootstrap then bootstrapFailure else pkgs.fetchurl {
          url = release.assets.aa64.url;
          hash = release.assets.aa64.hash;
          name = release.assets.aa64.file;
        };
        defaultPackage = pkgs.runCommand "systemd-boot-${release.systemdVersion}-bundle" { } ''
          mkdir -p $out
          tar -xzf ${bundleAsset} -C $out
        '';
        nativeBuildPackage =
          if isLinux then
            let
              nativeAsset = if pkgs.stdenv.hostPlatform.isx86_64 then {
                file = "systemd-bootx64.efi";
                path = "${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootx64.efi";
              } else {
                file = "systemd-bootaa64.efi";
                path = "${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootaa64.efi";
              };
            in
            pkgs.runCommand "systemd-boot-build-from-nixpkgs-${pkgs.systemd.version}" { } ''
              mkdir -p $out
              cp ${nativeAsset.path} $out/${nativeAsset.file}
              cat > $out/manifest.json <<EOF
              {
                "systemdVersion": "${pkgs.systemd.version}",
                "releaseTag": "systemd-v${pkgs.systemd.version}",
                "asset": "${nativeAsset.file}",
                "system": "${system}"
              }
EOF
            ''
          else
            null;
      in {
        packages = {
          default = defaultPackage;
          x64 = x64Asset;
          aa64 = aa64Asset;
        } // pkgs.lib.optionalAttrs isLinux {
          build-from-nixpkgs = nativeBuildPackage;
        };

        checks = {
          default = if isLinux then pkgs.runCommand "systemd-boot-native-check" { } ''
            test -s ${nativeBuildPackage}/manifest.json
            mkdir -p $out
          '' else pkgs.runCommand "systemd-boot-prebuilt-check" { } ''
            mkdir -p $out
          '';
        };
      });
}

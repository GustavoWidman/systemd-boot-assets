{
  description = "Pinned systemd-boot EFI binaries built with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      supportedSystems = [ "x86_64-linux" ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
        systemdAa64 = pkgs.pkgsCross.aarch64-multiplatform.systemd;
      in {
        packages = {
          default = pkgs.runCommand "systemd-boot-efi-assets-${pkgs.systemd.version}" { } ''
            mkdir -p $out
            cp ${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootx64.efi $out/systemd-bootx64.efi
            cp ${systemdAa64}/lib/systemd/boot/efi/systemd-bootaa64.efi $out/systemd-bootaa64.efi
            cat > $out/manifest.json <<EOF
            {
              "systemdVersion": "${pkgs.systemd.version}",
              "assets": {
                "x64": "systemd-bootx64.efi",
                "aa64": "systemd-bootaa64.efi"
              }
            }
EOF
          '';
        };

        checks.default = pkgs.runCommand "systemd-boot-efi-assets-check" { } ''
          test -s ${self.packages.${system}.default}/systemd-bootx64.efi
          test -s ${self.packages.${system}.default}/systemd-bootaa64.efi
          mkdir -p $out
        '';
      });
}

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
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
        asset = if system == "x86_64-linux" then {
          name = "systemd-bootx64";
          path = "${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootx64.efi";
          file = "systemd-bootx64.efi";
        } else {
          name = "systemd-bootaa64";
          path = "${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootaa64.efi";
          file = "systemd-bootaa64.efi";
        };
      in {
        packages = {
          default = pkgs.runCommand "${asset.name}-${pkgs.systemd.version}" { } ''
            mkdir -p $out
            cp ${asset.path} $out/${asset.file}
            cat > $out/manifest.json <<EOF
            {
              "systemdVersion": "${pkgs.systemd.version}",
              "asset": "${asset.file}",
              "system": "${system}"
            }
EOF
          '';
        };

        checks.default = pkgs.runCommand "${asset.name}-check" { } ''
          test -s ${self.packages.${system}.default}/${asset.file}
          mkdir -p $out
        '';
      });
}

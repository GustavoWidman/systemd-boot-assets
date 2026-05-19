# systemd-boot-assets

Tiny release builder for `systemd-boot` EFI binaries.

The repository does not store EFI binaries in git. A scheduled GitHub Actions workflow updates `nixpkgs`, builds native Linux `systemd-boot` assets with Nix, publishes GitHub release assets, then rewrites `release.nix` with pinned URLs and SRI hashes.

Release tags use this shape:

```text
systemd-v260.1
```

Each release contains:

```text
systemd-bootx64.efi
systemd-bootaa64.efi
manifest.json
SHA256SUMS
systemd-boot-bundle.tar.gz
```

## Build locally

Build the native CI package on x86_64 Linux:

```sh
nix build .#packages.x86_64-linux.build-from-nixpkgs
```

Build the native CI package on aarch64 Linux:

```sh
nix build .#packages.aarch64-linux.build-from-nixpkgs
```

Each native build output contains the EFI binary for that architecture and a `manifest.json` file.

## Use from another flake

Downstream projects should use the prebuilt release assets, not the native build package:

```nix
{
  inputs.systemd-boot-assets.url = "github:GustavoWidman/systemd-boot-assets";

  outputs = { self, nixpkgs, systemd-boot-assets, ... }: {
    packages.x86_64-darwin.default = systemd-boot-assets.packages.x86_64-darwin.default;
  };
}
```

Useful outputs:

- `packages.${system}.default`: bundle directory with both EFI binaries, `manifest.json`, and `SHA256SUMS`
- `packages.${system}.x64`: pinned `systemd-bootx64.efi`
- `packages.${system}.aa64`: pinned `systemd-bootaa64.efi`
- `packages.x86_64-linux.build-from-nixpkgs`: native CI build from `pkgs.systemd`
- `packages.aarch64-linux.build-from-nixpkgs`: native CI build from `pkgs.systemd`

`release.nix` is seeded with placeholder hashes until the first GitHub release exists. Bootstrap updates come from CI after it publishes the first real assets.

# systemd-boot-assets

Tiny release builder for `systemd-boot` EFI binaries.

The repository does not store EFI binaries in git. A scheduled GitHub Actions workflow updates `nixpkgs`, builds `systemd-bootx64.efi` and `systemd-bootaa64.efi` with Nix, then publishes them as release assets when the release tag for that systemd version is missing.

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
```

## Build locally

```sh
nix build .#packages.x86_64-linux.default
```

The output contains both EFI binaries:

```text
result/systemd-bootx64.efi
result/systemd-bootaa64.efi
result/manifest.json
```

## Use from another flake

Fetch release assets with fixed-output `fetchurl` hashes and point your image builder at the fetched paths. That keeps downstream projects from evaluating the Linux-only `systemd` package on Darwin.

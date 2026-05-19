#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

version=$(nix eval --raw "$repo_root#packages.x86_64-linux.build-from-nixpkgs.name" \
  | sed 's/^systemd-boot-build-from-nixpkgs-//')

printf '%s\n' "$version"

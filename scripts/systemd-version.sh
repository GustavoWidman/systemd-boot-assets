#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

version=$(nix eval --raw "$repo_root#packages.x86_64-linux.default.name" \
  | sed 's/^systemd-bootx64-//')

printf '%s\n' "$version"

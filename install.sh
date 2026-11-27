#!/usr/bin/env bash
# install.sh
# Clones this flake, adopts the machine's hardware configuration and user name,
# then rebuilds NixOS from it. Safe to re-run.
set -euo pipefail

RED='\033[1;31m' GREEN='\033[1;32m' YELLOW='\033[1;33m' BLUE='\033[1;34m' NC='\033[0m'
say() { printf "${1}%s${NC}\n" "$2"; }

REPO_URL="https://github.com/0x7FFE02D0/config.git"
REPO_BRANCH="main"
HOST="nixos"
REPO_DIR="$(basename "$REPO_URL" .git)"
# Enables flakes for this script only, without editing /etc/nixos.
export NIX_CONFIG="experimental-features = nix-command flakes"

[ -e /etc/NIXOS ] || { say "$RED" "This script only runs on NixOS."; exit 1; }
[ "$(id -u)" -ne 0 ] || { say "$RED" "Run as your normal user, not root."; exit 1; }

if [ -d "$REPO_DIR/.git" ]; then
  say "$YELLOW" "$REPO_DIR already exists; pulling latest $REPO_BRANCH."
  nix shell nixpkgs#git -c git -C "$REPO_DIR" pull --ff-only
else
  say "$BLUE" "Cloning $REPO_URL ($REPO_BRANCH)."
  nix shell nixpkgs#git -c git clone -b "$REPO_BRANCH" "$REPO_URL" "$REPO_DIR"
fi

if [ -f /etc/nixos/hardware-configuration.nix ]; then
  say "$YELLOW" "Using this machine's hardware-configuration.nix."
  cp /etc/nixos/hardware-configuration.nix "$REPO_DIR/hardware-configuration.nix"
else
  say "$RED" "/etc/nixos/hardware-configuration.nix not found; keeping the repo's copy."
fi

sed -i "s/username = \"[^\"]*\";/username = \"$(id -un)\";/" "$REPO_DIR/user.nix"

say "$BLUE" "Rebuilding from $REPO_DIR#$HOST."
sudo --preserve-env=NIX_CONFIG nixos-rebuild switch --flake "$PWD/$REPO_DIR#$HOST"

say "$GREEN" "System rebuilt successfully."

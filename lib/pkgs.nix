# lib/pkgs.nix
# The nixpkgs package set used for Home Manager and the flake packages.
{
  nixpkgs,
  system,
  overlays,
}:

import nixpkgs {
  inherit system overlays;
  config.allowUnfree = true;
}

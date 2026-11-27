# packages/default.nix
# Custom packages, exposed as packages.<system>.<name>.
{ pkgs, ... }:

{
  cursor = pkgs.callPackage ./cursor.nix { };
}

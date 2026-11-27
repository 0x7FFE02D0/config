# dev/default.nix
# Extra development shells, exposed as devShells.<system>.<name>.
{ pkgs }:

{
  nodejs = import ./nodejs.nix { inherit pkgs; };
}

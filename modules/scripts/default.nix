# modules/scripts/default.nix
# Bash function overrides for everyday commands.
{ ... }:

{
  imports = [
    ./git-wrapper.nix
    ./unzip.nix
  ];
}

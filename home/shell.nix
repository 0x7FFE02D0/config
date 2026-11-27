# home/shell.nix
# Bash aliases.
{ ... }:

{
  programs.bash = {
    shellAliases = {
      ll = "ls -l";
      gs = "git status";
      gpull = "git pull";
      gpush = "git push";
      # install.sh clones the flake to ~/config. Home Manager runs as a NixOS
      # module here, so this rebuild also applies the home configuration.
      rebuild = "sudo nixos-rebuild switch --flake ~/config#nixos";
    };
  };
}

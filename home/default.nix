# home/default.nix
# Imports every .nix file in home/ (except *.userChrome.nix fragments),
# passing each one only the arguments it asks for.
args@{ ... }:

let
  # Extract lib early so it's available below
  lib = args.lib;

  allFiles = builtins.attrNames (builtins.readDir ./.);

  nixFiles = builtins.filter (
    name: lib.hasSuffix ".nix" name && name != "default.nix" && !(lib.hasSuffix ".userChrome.nix" name)
  ) allFiles;

  importWithAutoArgs =
    name:
    let
      path = ./${name};
      argsNeeded = builtins.functionArgs (import path);
      argsToPass = builtins.intersectAttrs argsNeeded args;
    in
    import path argsToPass;

  modules = builtins.map importWithAutoArgs nixFiles;

in
{
  imports = modules;
}

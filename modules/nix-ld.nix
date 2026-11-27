# modules/nix-ld.nix
# Lets unpatched dynamically linked binaries find common libraries.
{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    glib
    libGL
    zlib
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXfixes
    fontconfig
    freetype
    SDL2
  ];
}

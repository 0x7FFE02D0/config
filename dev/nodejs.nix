# dev/nodejs.nix
# Node.js development shell. Override `nodeVersion` to pick another Node.js.
{ pkgs, nodeVersion ? pkgs.nodejs_24 }:

pkgs.mkShell {
  # npm ships with Node.js itself.
  packages = [
    nodeVersion
    pkgs.yarn
  ];

  shellHook = ''
    echo "Node.js (${nodeVersion.version or "default"}) dev shell activated."
    export NODE_ENV=development
  '';
}

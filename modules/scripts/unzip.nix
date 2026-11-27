# modules/scripts/unzip.nix
# Adds `unzip all`, which extracts every .zip in the current directory
# into a folder of the same name.
{ lib, ... }:

{
  # Override 'unzip' command with bulk unzip functionality
  programs.bash.shellInit = lib.strings.concatStringsSep "\n" [
    ''
      unzip() {
        if [[ "$1" == "all" ]]; then
          for zipfile in *.zip; do
            [ -e "$zipfile" ] || continue
            foldername=$(basename "$zipfile" .zip)
            echo "Unzipping '$zipfile' into folder: '$foldername'"
            mkdir -p "$foldername"
            command unzip -q "$zipfile" -d "$foldername"
          done
        else
          echo "Unzipping individual file: $*"
          command unzip "$@"
        fi
      }
    ''
  ];
}

# home/xdg.nix
# XDG user directories and default applications.
{ ... }:

{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      music = "/mnt/Backups/Music";
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "application/pdf" = [ "org.gnome.Papers.desktop" ];
      };
    };
  };
}

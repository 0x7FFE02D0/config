# disko.nix
# Disk layout for fresh installs of this machine. Apply with:
#   sudo nix run github:nix-community/disko -- --mode destroy,format,mount ./disko.nix
# This wipes the disk below.
#
# This machine still mounts its existing partitions by UUID from
# hardware-configuration.nix, so disko does not generate any mounts here.
{
  disko.enableConfig = false;

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };
        swap = {
          size = "16G";
          content.type = "swap";
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}

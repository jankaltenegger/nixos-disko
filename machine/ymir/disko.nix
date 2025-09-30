# disko.nix
{
  disko.devices = {
    disk.main = {
      device = "/dev/disk/by-id/REPLACE_ME";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
              mountOptions = [ "umask=0077" ];
            };
          };

          crypt = {
            name = "niflheim_crypt";
            size = "100%";
            content = {
              type = "luks";
              name = "niflheim";
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "vg_niflheim";
              };
            };
          };
        };
      };
    };

    lvm_vg.vg_niflheim = {
      type = "lvm_vg";
      lvs = {
        lv_boot = {
          size = "1G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/boot";
            mountOptions = [ "noatime" ];
          };
        };
        lv_nix = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
            mountOptions = [ "noatime" ];
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "mode=755" "size=8G" ];
    };
  };
}

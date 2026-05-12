{inputs, ...}: {
  flake.nixosModules.coruscant = _: {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["noexec" "nosuid" "nodev" "fmask=0077" "dmask=0077"];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "securoot";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "nixos" "-f"];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = ["noatime" "compress=zstd:1"];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["noatime" "nosuid" "nodev" "compress=zstd:3"];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = ["noatime" "nosuid" "nodev" "compress=zstd:1"];
                    };
                  };
                };
              };
            };
          };
        };
      };

      nodev = {
        "/tmp" = {
          fsType = "tmpfs";
          mountOptions = ["noexec" "nosuid" "nodev" "size=8G" "mode=1777"];
        };
        "/var/tmp" = {
          fsType = "tmpfs";
          mountOptions = ["noexec" "nosuid" "nodev" "size=8G" "mode=1777"];
        };
      };
    };
  };
}

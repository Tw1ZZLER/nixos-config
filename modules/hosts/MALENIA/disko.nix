# Disk layout for MALENIA (microSD via nixos-anywhere + disko)
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.malenia-disko = {...}: {
    disko.devices = {
      disk = {
        main = {
          # Target drive path on the Pi.
          # Use "/dev/mmcblk0" for a MicroSD card or "/dev/sda" if installing directly to a USB/NVMe SSD.
          device = "/dev/mmcblk0";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              # Firmware & Boot partition required by Raspberry Pi EEPROM
              boot = {
                size = "512M";
                type = "EF00"; # Identifies as an EFI System Partition
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              # Main Operating System Partition
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
      };
    };
  };
}

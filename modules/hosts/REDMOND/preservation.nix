# Preservation configuration for REDMOND
# Explode root on every boot!
# credit: https://www.youtube.com/watch?v=ZKBSWS7OOb4
# credit: https://www.vimjoyer.com/vid89-impermanent
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.REDMOND = {lib, ...}: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    preservation = {
      enable = true;

      # persistent files and directories
      preserveAt."/persist" = {
        directories = [
          "/var/log"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/timers"
          "/var/lib/displaymanager"
          {
            directory = "/var/lib/colord";
            user = "colord";
            group = "colord";
            mode = "u=rwx,g=rx,o=";
          }

          # sound system configurations
          "/var/lib/pipewire"
          "/var/lib/alsa"

          # printing and printers and stuff
          "/var/lib/cups"

          # wifi / bluetooth credentials
          "/etc/NetworkManager/system-connections"
          "/var/lib/bluetooth"

          # containers / vms
          "/var/lib/docker"
          "/var/lib/containers"
          "/var/lib/libvirt"

          # tailscale authentication stuff
          "/var/lib/tailscale"
          "/var/lib/wireguard"
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
          {
            file = "/etc/nix/id_rsa";
            parent = {
              mode = "u=rwx,g=,o=";
            };
          }
          {
            file = "/var/lib/systemd/random-seed";
            # create a symlink on the volatile volume
            how = "symlink";
            # prepare the preservation early during startup
            inInitrd = true;
          }
          {
            file = "/etc/ssh/ssh_host_rsa_key";
            how = "symlink";
            configureParent = true;
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key";
            how = "symlink";
            configureParent = true;
          }
        ];
      };
    };

    # stage-1 initrd script: Wipe @root subvolume before mounting
    # boot.initrd.supportedFilesystems = ["btrfs"];
    # boot.initrd.postDeviceCommands = lib.mkAfter ''
    #   mkdir -p /tmp/mnt
    #   mount /dev/disk/by-partlabel/disk-main-root /tmp/mnt -o subvolid=5 # CONFIRM THIS IS CORRECT FROM findmnt
    #   mount /dev/nvme0n1p2 /tmp/mnt -o subvolid=5
    #   if [ -e /tmp/mnt/@root ]; then
    #       mkdir -p /tmp/mnt/@root_old
    #       timestamp=$(date +%Y-%m-%d_%H:%M:%S)
    #       mv /tmp/mnt/@root "/tmp/mnt/@root_old/$timestamp"
    #   fi
    #   btrfs subvolume create /tmp/mnt/@root
    #   umount /tmp/mnt
    # '';
  };
}

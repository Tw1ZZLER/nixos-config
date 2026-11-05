# ONU CIFS mounting configuration for NixOS
# https://nixos.wiki/wiki/Samba#CIFS_mount_configuration
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.onu-drives = {...}: {
    # For mount.cifs, required unless domain name resolution is not needed.
    imports = with self.nixosModules; [
      cifs
      samba
    ];

    fileSystems."/home/tw1zzler/drive/onu-hdrive" = {
      device = "//onufs01.onu.edu/home/c-hibler";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  };
}

# ONU CIFS mounting configuration for NixOS
# https://nixos.wiki/wiki/Samba#CIFS_mount_configuration
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    onu-drives.enable = lib.mkEnableOption "Enable ONU CIFS drive mounts";
  };
  config = lib.mkIf config.onu-drives.enable {
    # For mount.cifs, required unless domain name resolution is not needed.
    cifs.enable = true;
    samba.enable = true;

    fileSystems."/mnt/H" = {
      device = "//onufs01.onu.edu/home/c-hibler";
      fsType = "cifs";
      options =
        let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

        in
        [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100" ];
      # or if you have specified `uid` and `gid` explicitly through NixOS configuration,
      # you can refer to them rather than hard-coding the values:
      # in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=${toString config.users.users.<username>.uid},gid=${toString config.users.groups.<group>.gid}"];
    };
  };
}

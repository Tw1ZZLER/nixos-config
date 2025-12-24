# Windows interoperability and file sharing settings (Windows printers are located in ./printing.nix)
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    samba.enable = lib.mkEnableOption "Enable Samba file sharing service";
  };

  config = lib.mkIf config.samba.enable {
    services = {
      samba = {
        enable = true;
        package = pkgs.samba4Full;
      };

      # Browse Samba shares
      # https://nixos.wiki/wiki/Samba#Browsing_samba_shares_with_GVFS
      gvfs.enable = true;

      # samba-wsdd = {
      #   enable = true;
      #   openFirewall = true;
      # };
    };
  };
}

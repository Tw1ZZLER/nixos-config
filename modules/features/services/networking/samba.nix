# Windows interoperability and file sharing settings (Windows printers are located in ./printing.nix)
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.samba = {...}: {
    services = {
      samba.enable = true;

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

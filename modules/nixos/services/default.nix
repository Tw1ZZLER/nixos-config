{ lib, ... }:
{
  imports = [
    ./flatpak.nix
    ./samba.nix
    ./stylix-wrapper.nix
    ./tailscale.nix
  ];

  flatpak.enable = lib.mkDefault false;
  samba.enable = lib.mkDefault true;
  stylix-wrapper.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

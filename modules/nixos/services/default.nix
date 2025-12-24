{ lib, ... }:
{
  imports = [
    ./catppuccin-nix.nix
    ./flatpak.nix
    ./samba.nix
    ./sound.nix
    ./stylix-wrapper.nix
    ./tailscale.nix
  ];

  catppuccin-nix.enable = lib.mkDefault false;
  flatpak.enable = lib.mkDefault false;
  samba.enable = lib.mkDefault true;
  sound.enable = lib.mkDefault true;
  stylix-wrapper.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

{ lib, ... }:
{
  imports = [
    ./networking
    ./catppuccin-nix.nix
    ./flatpak.nix
    ./stylix-wrapper.nix
  ];

  catppuccin-nix.enable = lib.mkDefault false;
  flatpak.enable = lib.mkDefault false; # COSMIC DE enables this
  stylix-wrapper.enable = lib.mkDefault true;
}

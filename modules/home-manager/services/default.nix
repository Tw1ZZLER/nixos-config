{ lib, ... }:
{
  imports = [
    ./catppuccin-nix.nix
    ./fonts.nix
    ./gnome-keyring.nix
    ./mpd.nix
    ./stylix-wrapper.nix
    ./syncthing.nix
    ./xdg-user-dirs.nix
  ];

  catppuccin.enable = lib.mkDefault false;
  fonts.enable = lib.mkDefault true;
  gnome-keyring.enable = lib.mkDefault true;
  mpd.enable = lib.mkDefault false;
  stylix-wrapper.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
  xdg-user-dirs.enable = lib.mkDefault true;
}

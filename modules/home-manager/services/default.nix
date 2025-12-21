{ lib, ... }:
{
  imports = [
    ./catppuccin-nix.nix
    ./dotfiles.nix
    ./fonts.nix
    ./mpd.nix
    ./stylix-wrapper.nix
    ./syncthing.nix
    ./xdg-user-dirs.nix
  ];

  catppuccin.enable = lib.mkDefault false;
  dotfiles.enable = lib.mkDefault true;
  fonts.enable = lib.mkDefault true;
  mpd.enable = lib.mkDefault false;
  stylix-wrapper.enable = lib.mkDefault false;
  syncthing.enable = lib.mkDefault true;
  xdg-user-dirs.enable = lib.mkDefault true;
}

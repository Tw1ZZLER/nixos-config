# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }:
{
  imports = [
    ../../modules/nixpkgs.nix
  ];

  # Enable MPD service (off by default)
  mpd.enable = true;

  # Disable some GUI apps that don't work due to graphics
  wezterm.enable = false;
  filelight.enable = false;
  ark.enable = false;
  gwenview.enable = false;
  stylix-wrapper.enable = false;
  gnome-keyring.enable = false;

  # Must pass hostname to Syncthing wrapper on non-NixOS hosts
  syncthing.hostName = "REDMOND";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

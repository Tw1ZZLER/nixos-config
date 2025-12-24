# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeModules

    # Or modules from other flakes
    inputs.nixcord.homeModules.nixcord
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Must pass hostname to Syncthing wrapper on non-NixOS hosts
  syncthing.hostName = "PRIMUS";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

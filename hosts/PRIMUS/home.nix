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
  ];

  # Enable Xilinx tooling (Vivado, Vitis, etc.)
  xilinx.enable = true;

  # Must pass hostname to Syncthing wrapper on non-NixOS hosts
  syncthing.hostName = "PRIMUS";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

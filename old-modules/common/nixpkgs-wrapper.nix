# This module for Nixpkgs is useful in both NixOS and home-manager, so it goes here (I am using it in both)
{
  outputs,
  lib,
  config,
  ...
}:
{
  options = {
    nixpkgs-wrapper.enable = lib.mkEnableOption "Enable common nixpkgs configuration";
  };
  config = lib.mkIf config.nixpkgs-wrapper.enable {
    nixpkgs = {
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages

        # Add overlays from other flakes (from inputs):
        outputs.overlays.nix-xilinx
      ];
      # Configure nixpkgs instance
      config = {
        allowUnfree = true;
      };
    };
  };
}

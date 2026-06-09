# This module for Nixpkgs is useful in both NixOS and home-manager, so it goes here (I am using it in both)
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nixpkgs-wrapper = {...}: {
    nixpkgs = {
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        # outputs.overlays.additions
        # outputs.overlays.modifications
        # outputs.overlays.unstable-packages

        # Add overlays from other flakes (from inputs):
        # outputs.overlays.nix-xilinx
      ];
      # Configure nixpkgs instance
      config = {
        allowUnfree = true;
      };
    };
  };

  flake.nixosModules.nixpkgs-wrapper = {...}: {
    nixpkgs = {
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        # outputs.overlays.additions
        # outputs.overlays.modifications
        # outputs.overlays.unstable-packages

        # Add overlays from other flakes (from inputs):
        # outputs.overlays.nix-xilinx
      ];
      # Configure nixpkgs instance
      config = {
        allowUnfree = true;
      };
    };
  };
}

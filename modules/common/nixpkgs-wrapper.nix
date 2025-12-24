# This module for Nixpkgs is useful in both NixOS and home-manager, so it goes here (I am using it in both)
{
  outputs,
  lib,
  config,
  ...
}:
let
  isNixOS = lib.hasAttrByPath [ "system" "build" ] config;
  isHomeManager = lib.hasAttr "home" config;
  isHomeManagerOnNixOS = isHomeManager && config ? home-manager && config.home-manager ? users;
  enableNixpkgsWrapper = isNixOS || (isHomeManager && !isHomeManagerOnNixOS);
in
{
  options.nixpkgs-wrapper.enable = lib.mkOption {
    type = lib.types.bool;
    default = enableNixpkgsWrapper;
    description = ''
      Enable nixpkgs-wrapper only if:
      1. Called as NixOS module
      2. Called as Home Manager module on non-NixOS
      Disabled when called as Home Manager module on NixOS.
    '';
  };

  config = lib.mkIf config.nixpkgs-wrapper.enable {
    nixpkgs = {
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
      ];
      # Configure nixpkgs instance
      config = {
        allowUnfree = true;
      };
    };
  };
}

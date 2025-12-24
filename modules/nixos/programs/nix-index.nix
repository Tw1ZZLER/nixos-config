{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];
  options = {
    nix-index.enable = lib.mkEnableOption "Enable nix-index tool for NixOS";
  };
  config = lib.mkIf config.nix-index.enable {
    programs = {
      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };

      # Disable command-not-found globally for flake-based systems
      command-not-found.enable = false;
    };
  };
}

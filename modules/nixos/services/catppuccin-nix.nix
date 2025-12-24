# Catppuccin-specific styling, alternative to Stylix
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    catppuccin-nix.enable = lib.mkEnableOption "Enable Catppuccin theme configuration";
  };
  config = lib.mkIf config.catppuccin-nix.enable {
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "red";
    };
  };
}

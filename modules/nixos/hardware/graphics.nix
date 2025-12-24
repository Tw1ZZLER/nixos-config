# Default graphics setup for NixOS systems
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    graphics.enable = lib.mkEnableOption "Enable default graphics setup with Vulkan support";
  };
  config = lib.mkIf config.graphics.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
      ];
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
      ];
    };
  };
}

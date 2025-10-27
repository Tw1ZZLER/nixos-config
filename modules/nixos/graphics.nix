# Default graphics setup for NixOS systems
{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
    driSupport = true;
    driSupport32Bit = true;
  };
}

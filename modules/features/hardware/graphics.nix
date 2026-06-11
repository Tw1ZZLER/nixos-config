# Default graphics setup for NixOS systems
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.graphics = {pkgs, ...}: {
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

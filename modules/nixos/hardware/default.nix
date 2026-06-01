{ lib, ... }:
with lib;
{
  imports = [
    ./argonne-printers.nix
    ./graphics.nix
    ./intel-graphics.nix
    ./onu-printers.nix
  ];

  argonne-printers.enable = mkDefault false;
  graphics.enable = mkDefault true;
  intel-graphics.enable = mkDefault false;
  onu-printers.enable = mkDefault false;
}

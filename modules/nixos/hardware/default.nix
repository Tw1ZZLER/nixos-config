{ lib, ... }:
{
  imports = [
    ./graphics.nix
    ./intel-graphics.nix
    ./onu-printers.nix
  ];

  graphics.enable = lib.mkDefault true;
  intel-graphics.enable = lib.mkDefault true;
  onu-printers.enable = lib.mkDefault false;
}

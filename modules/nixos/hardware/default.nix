{ lib, ... }:
{
  imports = [
    ./graphics.nix
    ./intel-graphics.nix
    ./onu-printers.nix
  ];

  graphics.enable = lib.mkDefault true;
  intel-graphics.enable = lib.mkDefault false;
  onu-printers.enable = lib.mkDefault false;
}

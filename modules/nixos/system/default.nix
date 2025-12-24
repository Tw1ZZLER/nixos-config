{ lib, ... }:
{
  imports = [
    ./users
    ./printing.nix
    ./sound.nix
    ./timezone.nix
  ];

  printing.enable = lib.mkDefault true;
  sound.enable = lib.mkDefault true;
  timezone.enable = lib.mkDefault true;
}

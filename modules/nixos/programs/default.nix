{ lib, ... }:
{
  imports = [
    ./weylus.nix
  ];

  weylus.enable = lib.mkDefault true;
}

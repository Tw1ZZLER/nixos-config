{ lib, ... }:
{
  imports = [
    ./nix-index.nix
    ./weylus.nix
  ];

  nix-index.enable = lib.mkDefault true;
  weylus.enable = lib.mkDefault true;
}

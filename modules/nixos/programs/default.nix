{ lib, ... }:
{
  imports = [
    ./nix-index.nix
    ./nix-ld.nix
    ./weylus.nix
  ];

  nix-index.enable = lib.mkDefault true;
  nix-ld.enable = lib.mkDefault true;
  weylus.enable = lib.mkDefault true;
}

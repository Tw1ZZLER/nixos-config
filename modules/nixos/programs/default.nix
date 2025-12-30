{ lib, ... }:
{
  imports = [
    ./nix-ld.nix
    ./seahorse.nix
    ./steam.nix
    ./trashy.nix
    ./weylus.nix
    ./wine.nix
  ];

  nix-ld.enable = lib.mkDefault true;
  seahorse.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  trashy.enable = lib.mkDefault true;
  weylus.enable = lib.mkDefault true;
  wine.enable = lib.mkDefault true;
}

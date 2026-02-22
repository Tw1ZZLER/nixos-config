{ lib, ... }:
with lib;
{
  imports = [
    ./fish.nix
    ./gpu-screen-recorder.nix
    ./nix-ld.nix
    ./seahorse.nix
    ./sops.nix
    ./steam.nix
    ./trashy.nix
    ./weylus.nix
    ./wine.nix
  ];

  fish.enable = mkDefault true;
  gpu-screen-recorder.enable = mkDefault true;
  nix-ld.enable = mkDefault true;
  seahorse.enable = mkDefault true;
  sops.enable = mkDefault true;
  steam.enable = mkDefault true;
  trashy.enable = mkDefault true;
  weylus.enable = mkDefault true;
  wine.enable = mkDefault true;
}

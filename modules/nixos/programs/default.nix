{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./fish.nix
    ./gpu-screen-recorder.nix
    ./nix-ld.nix
    ./seahorse.nix
    ./sops.nix
    ./steam.nix
    ./system76-keyboard-configurator.nix
    ./trashy.nix
    ./waveforms.nix
    ./weylus.nix
    ./wine.nix
  ];

  fish.enable = mkDefault true;
  gpu-screen-recorder.enable = mkDefault true;
  nix-ld.enable = mkDefault true;
  seahorse.enable = mkDefault true;
  sops.enable = mkDefault true;
  steam.enable = mkDefault true;
  system76-keyboard-configurator.enable = mkDefault true;
  trashy.enable = mkDefault true;
  waveforms.enable = mkDefault false;
  weylus.enable = mkDefault true;
  wine.enable = mkDefault true;
}

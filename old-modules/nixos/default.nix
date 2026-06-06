# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{ lib, ... }:
{
  imports = [
    ../common
    ./desktop
    ./hardware
    ./programs
    ./services
    ./system
    ./virtualisation
  ];
}

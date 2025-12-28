{ lib, ... }:
{
  imports = [
    ./cosmic.nix
    ./hyprland.nix
    ./plymouth.nix
  ];

  cosmic.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  plymouth.enable = lib.mkDefault false;
}

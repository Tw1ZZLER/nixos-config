{ lib, ... }:
{
  imports = [
    ./cosmic.nix
    ./hyprland.nix
    ./ly.nix
    ./plymouth.nix
  ];

  cosmic.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  ly.nenable = lib.mkDefault false;
  plymouth.enable = lib.mkDefault false;
}

{ lib, ... }:
{
  imports = [
    ./cosmic-greeter.nix
    ./cosmic.nix
    ./hyprland.nix
    ./ly.nix
    ./plymouth.nix
  ];

  cosmic-greeter.enable = lib.mkDefault false;
  cosmic.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault false;
  ly.enable = lib.mkDefault false;
  plymouth.enable = lib.mkDefault false;
}

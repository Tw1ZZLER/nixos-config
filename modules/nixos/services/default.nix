{ lib, ... }:
{
  imports = [
    ./flatpak.nix
    ./stylix-wrapper.nix
    ./tailscale.nix
  ];

  flatpak.enable = lib.mkDefault false;
  stylix-wrapper.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

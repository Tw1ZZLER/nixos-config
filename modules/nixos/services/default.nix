{ lib, ... }:
{
  imports = [
    ./stylix-wrapper.nix
    ./tailscale.nix
  ];

  stylix-wrapper.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

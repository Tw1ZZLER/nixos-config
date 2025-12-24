{ lib, ... }:
{
  imports = [
    ./tailscale.nix
  ];

  tailscale.enable = lib.mkDefault true;
}

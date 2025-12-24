{ lib, ... }:
{
  imports = [
    ./cosmic.nix
    ./plymouth.nix
  ];

  cosmic.enable = lib.mkDefault false;
  plymouth.enable = lib.mkDefault false;
}

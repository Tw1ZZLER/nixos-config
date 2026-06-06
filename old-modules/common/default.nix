{ lib, ... }:
{
  imports = [
    ./nixpkgs-wrapper.nix
  ];

  nixpkgs-wrapper.enable = lib.mkDefault true;
}

{ lib, ... }:
{
  imports = [
    ./docker.nix
    ./virt-manager.nix
  ];

  docker.enable = lib.mkDefault true;
  virt-manager.enable = lib.mkDefault true;
}

{ lib, ... }:
{
  imports = [
    ./nix-index.nix
    ./nix-ld.nix
    ./steam.nix
    ./virt-manager.nix
    ./weylus.nix
  ];

  nix-index.enable = lib.mkDefault true;
  nix-ld.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  virt-manager.enable = lib.mkDefault true;
  weylus.enable = lib.mkDefault true;
}

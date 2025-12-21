{ lib, ... }:
{
  imports = [
    ./exercism.nix
    ./fish.nix
    ./git.nix
    ./ncmpcpp.nix
    ./neovim.nix
    ./nix-helper.nix
    ./python.nix
    ./rmpc.nix
    ./sqlite.nix
    ./starship.nix
    ./wget.nix
  ];

  exercism.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  ncmpcpp.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  nix-helper.enable = lib.mkDefault true;
  python.enable = lib.mkDefault true;
  rmpc.enable = lib.mkDefault true;
  sqlite.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  wget.enable = lib.mkDefault true;
}

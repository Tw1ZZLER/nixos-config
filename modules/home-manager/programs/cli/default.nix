{ lib, ... }@args:
let
  inherit (lib) mkDefault mkIf;
in
{
  imports = [
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./exercism.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./lazyvim.nix
    ./neovim.nix
    ./nix-helper.nix
    ./nix-index.nix
    ./nixgl.nix
    ./python.nix
    ./ripgrep.nix
    ./rmpc.nix
    ./sqlite.nix
    ./starship.nix
    ./wget.nix
    ./yazi.nix
  ];

  bat.enable = mkDefault true;
  btop.enable = mkDefault true;
  direnv.enable = mkDefault true;
  exercism.enable = mkDefault true;
  eza.enable = mkDefault true;
  fastfetch.enable = mkDefault true;
  fd.enable = mkDefault true;
  fish.enable = mkDefault true;
  fzf.enable = mkDefault true;
  git.enable = mkDefault true;
  lazyvim.enable = mkDefault true;
  neovim.enable = mkDefault false;
  nix-helper.enable = mkDefault true;
  nix-index.enable = mkDefault true;
  nixgl.enable = mkIf (args ? osConfig) (mkDefault true);
  python.enable = mkDefault true;
  ripgrep.enable = mkDefault true;
  rmpc.enable = mkDefault true;
  sqlite.enable = mkDefault true;
  starship.enable = mkDefault true;
  wget.enable = mkDefault true;
  yazi.enable = mkDefault true;
}

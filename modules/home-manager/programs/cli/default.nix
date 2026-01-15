{ lib, ... }@args:
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

  bat.enable = lib.mkDefault true;
  btop.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  exercism.enable = lib.mkDefault true;
  eza.enable = lib.mkDefault true;
  fastfetch.enable = lib.mkDefault true;
  fd.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  fzf.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  nix-helper.enable = lib.mkDefault true;
  nix-index.enable = lib.mkDefault true;
  nixgl.enable = lib.mkIf (args ? osConfig) (lib.mkDefault true);
  python.enable = lib.mkDefault true;
  ripgrep.enable = lib.mkDefault true;
  rmpc.enable = lib.mkDefault true;
  sqlite.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  wget.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
}

# My personal shell environment with commonly used utilities
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.shell = {pkgs, ...}: {
    imports = with self.homeModules; [
      btop
      direnv
      fastfetch
      fish
      git
      neovim
      nix-helper
      nix-index
      rbw
      starship
      tmux
      yazi
    ];

    home.packages = with pkgs; [
      gh # GitHub CLI
      codeberg-cli # gh-like tool for Codeberg
      nix-output-monitor # nom, can be used instead of nix
      nvd # nix diffing tool, makes updates look good
      wget
    ];

    programs = {
      bat.enable = true; # cat replacement
      eza.enable = true; # ls replacement
      fd.enable = true; # find replacement
      fzf.enable = true; # fuzzy finder
      ripgrep.enable = true; # grep replacement
    };
  };
}

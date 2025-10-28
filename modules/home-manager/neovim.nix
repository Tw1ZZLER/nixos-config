# The best text editor
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = with pkgs.unstable; [
      # Idk why LazyVim needs this but it does
      unzip
      sqlite

      # Snacks.image requirements (Mermaid diagrams and PDFs)
      mermaid-cli
      ghostscript

      # Nix Formatter
      nixfmt-rfc-style

      # Required by Snacks.image
      imagemagick

      # Tree-sitter requirement
      tree-sitter

      # LaTeX (TeXLive) Stuff
      texliveMedium
      texlivePackages.biber
    ];
    extraLuaPackages =
      luaPkgs: with pkgs.unstable.lua51Packages; [
        luautf8
        luarocks
      ];
    extraPython3Packages =
      pyPkgs: with pkgs.unstable.python312Packages; [
        pynvim

        # LaTeX support
        pylatexenc
      ];
  };
  xdg.configFile."nvim".source = ../../dotfiles/nvim;
}

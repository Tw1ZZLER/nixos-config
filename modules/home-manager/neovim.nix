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

      # Marksman requirement
      icu

      # Nix Formatter
      nixfmt-rfc-style

      # Required by Snacks.image
      imagemagick

      # Tree-sitter requirement
      tree-sitter

      # LaTeX (TeXLive) Stuff
      (pkgs.unstable.texlive.combine {
        inherit (pkgs.unstable.texlive)
          scheme-medium # or scheme-small, or scheme-full if you want everything
          biber
          standalone
          amsmath
          xcolor
          mathtools
          amsfonts
          varwidth
          preview
          ;
      })

      # Lua Stuff
      lua51Packages.lua
      lua51Packages.luautf8
      lua51Packages.luarocks

      # Python stuff
      python312Packages.pynvim
      python312Packages.pylatexenc

      # Apparently we also need some Java stuff for ltex
      jdk21
    ];
  };
  xdg.configFile."nvim".source = ../../dotfiles/nvim;
}

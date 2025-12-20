{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    neovim.enable = lib.mkEnableOption "Enable Neovim configuration";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs.unstable; [
        unzip
        sqlite
        mermaid-cli
        ghostscript
        icu
        rust-analyzer
        nixfmt-rfc-style
        statix
        imagemagick
        tree-sitter
        (pkgs.unstable.texlive.combine {
          inherit (pkgs.unstable.texlive)
            scheme-medium
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
        lua51Packages.lua
        lua51Packages.luautf8
        lua51Packages.luarocks
        python312Packages.pynvim
        python312Packages.pylatexenc
        jdk21
      ];
    };
    xdg.configFile.nvim = {
      recursive = true;
      source = ../../dotfiles/nvim;
    };
  };
}

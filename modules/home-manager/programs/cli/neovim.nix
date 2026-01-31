{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.mnw.homeManagerModules.default ];
  options = {
    neovim.enable = lib.mkEnableOption "Enable Neovim configuration";
  };

  config = lib.mkIf config.neovim.enable {
    home = {
      shellAliases.vimdiff = "nvim -d";
      sessionVariables.EDITOR = "nvim";
    };
    programs.mnw = {
      enable = true;
      neovim = pkgs.unstable.neovim-unwrapped;
      aliases = [
        "vi"
        "nvim"
      ];
      provides.nodeJs.enable = true;
      extraBinPath = with pkgs.unstable; [
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
      plugins = {
        start = [ ];
        opt = [ ];
        dev.myConfig = {
          pure = ../../../../dotfiles/nvim;
        };
      };
    };
  };
}

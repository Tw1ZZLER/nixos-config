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
      appName = "nvim";
      aliases = [
        "vi"
        "vim"
      ];

      initLua = ''
        require("config.options")
        require("config.keymaps")
        require("config.autocmds")
        LZN = require("lz.n")
        LZN.load("plugins")
      '';

      extraLuaPackages = ps: [ ps.jsregexp ];

      providers.nodeJs.enable = true;
      extraBinPath = with pkgs.unstable; [
        unzip
        sqlite
        fd
        ripgrep
        fzf
        lazygit
        stylua
        prettierd
        shfmt
        mermaid-cli
        ghostscript
        icu
        rust-analyzer
        nil
        lua-language-server
        nixfmt-rfc-style
        statix
        deadnix
        ltex-ls
        pyright
        texlab
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

      plugins = with pkgs.unstable.vimPlugins; {
        start = [
          lz-n
          plenary-nvim
          which-key-nvim
          nvim-web-devicons
        ] ++ nvim-treesitter.withAllGrammars.dependencies;

        opt = [
          catppuccin-nvim
          snacks-nvim
          lualine-nvim
          fzf-lua
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp_luasnip
          friendly-snippets
          nvim-lint
          gitsigns-nvim
          trouble-nvim
          noice-nvim
          nvim-notify
          obsidian-nvim
          vimtex
        ];

        optAttrs = {
          "flash.nvim" = pkgs.unstable.vimPlugins.flash-nvim;
          "todo-comments.nvim" = pkgs.unstable.vimPlugins.todo-comments-nvim;
          "persistence.nvim" = pkgs.unstable.vimPlugins.persistence-nvim;
          "conform.nvim" = pkgs.unstable.vimPlugins.conform-nvim;
          "indent-blankline.nvim" = pkgs.unstable.vimPlugins.indent-blankline-nvim;
          "mini.nvim" = pkgs.unstable.vimPlugins.mini-nvim;
          "ts-comments.nvim" = pkgs.unstable.vimPlugins.ts-comments-nvim;
        };

        dev.myConfig = {
          pure = ../../../../dotfiles/nvim;
        };
      };
    };
  };
}

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
      shellAliases.nvim-dev = "${config.programs.mnw.finalPackage.devMode}/bin/nvim";
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
        nil
        lua-language-server
        nixfmt
        statix
        deadnix
        basedpyright
        ruff
        imagemagick
        tree-sitter
        nodePackages.markdownlint-cli2
        lua51Packages.lua
        lua51Packages.luautf8
        lua51Packages.luarocks
        python312Packages.pynvim
      ];

      plugins = with pkgs.unstable.vimPlugins; {
        start = [
          lz-n
          plenary-nvim
          which-key-nvim
          nvim-web-devicons
          nvim-treesitter
        ]
        ++ nvim-treesitter.withAllGrammars.dependencies;

        opt = [
          catppuccin-nvim
          snacks-nvim
          lualine-nvim
          fzf-lua
          bufferline-nvim
          blink-cmp
          nvim-lspconfig
          grug-far-nvim
          yanky-nvim
          dial-nvim
          luasnip
          harpoon2
          vim-illuminate
          flit-nvim
          vim-repeat
          mini-diff
          mini-files
          outline-nvim
          overseer-nvim
          obsidian-nvim
          refactoring-nvim
          neogen
          nvim-dap-ui
          edgy-nvim
          gh-nvim
          friendly-snippets
          nvim-lint
          gitsigns-nvim
          trouble-nvim
          noice-nvim
          nvim-notify
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
          impure = "/home/tw1zzler/nixos-config/dotfiles/nvim";
        };
      };
    };
  };
}

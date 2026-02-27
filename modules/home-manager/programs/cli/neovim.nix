{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.mnw.homeManagerModules.default];
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

      extraLuaPackages = ps: [ps.jsregexp];

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
        imagemagick
        tree-sitter
        nodePackages.markdownlint-cli2
        lua51Packages.lua
        lua51Packages.luautf8
        lua51Packages.luarocks
        python312Packages.pynvim

        # Language servers
        nil # Nix
        lua-language-server # Lua
        basedpyright # Python
        ruff # Python (linter/formatter)
        clang-tools # C/C++ (clangd + clang-format)
        haskell-language-server # Haskell
        rust-analyzer # Rust
        jdt-language-server # Java

        # Formatters
        nixfmt # Nix
        fourmolu # Haskell

        # Linters
        statix # Nix
        deadnix # Nix
        hlint # Haskell
      ];

      plugins = with pkgs.unstable.vimPlugins; {
        start =
          [
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

          # Language extras
          rustaceanvim
          nvim-jdtls
        ];

        optAttrs = {
          "flash.nvim" = pkgs.unstable.vimPlugins.flash-nvim;
          "todo-comments.nvim" = pkgs.unstable.vimPlugins.todo-comments-nvim;
          "persistence.nvim" = pkgs.unstable.vimPlugins.persistence-nvim;
          "conform.nvim" = pkgs.unstable.vimPlugins.conform-nvim;
          "indent-blankline.nvim" = pkgs.unstable.vimPlugins.indent-blankline-nvim;
          "mini.nvim" = pkgs.unstable.vimPlugins.mini-nvim;
          "ts-comments.nvim" = pkgs.unstable.vimPlugins.ts-comments-nvim;

          # Language extras
          "haskell-tools.nvim" = pkgs.unstable.vimPlugins.haskell-tools-nvim;
          "crates.nvim" = pkgs.unstable.vimPlugins.crates-nvim;
          "clangd_extensions.nvim" = pkgs.unstable.vimPlugins.clangd_extensions-nvim;
          "haskell-snippets.nvim" = pkgs.unstable.vimPlugins.haskell-snippets-nvim;
          "lazydev.nvim" = pkgs.unstable.vimPlugins.lazydev-nvim;
        };

        dev.myConfig = {
          pure = ../../../../dotfiles/nvim;
          impure = "/home/tw1zzler/nixos-config/dotfiles/nvim";
        };
      };
    };
  };
}

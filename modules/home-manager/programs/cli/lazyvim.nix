{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.lazyvim.homeManagerModules.default ];
  options = {
    lazyvim.enable = lib.mkEnableOption "Enable Lazyvim Neovim Configuration (lazyvim-nix)";
  };

  config = lib.mkIf config.lazyvim.enable {
    programs.lazyvim = {
      enable = true;

      # Custom config directory (optional, defaults to "nvim")
      appName = "lazyvim"; # Creates config in ~/.config/lazyvim/

      extras = {
        ai = {
          copilot.enable = true;
          avante.enable = true;
        };
        coding = {
          blink.enable = true;
          luasnip.enable = true;
        };
        lang = {
          go = {
            enable = true;
            installDependencies = true; # Install gopls, gofumpt, etc.
            installRuntimeDependencies = true; # Install go compiler
          };
          haskell = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          java = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          json = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          markdown = {
            enable = true;
            installDependencies = false;
            installRuntimeDependencies = true;
          };
          nix = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          python = {
            enable = true;
            installDependencies = true; # Install ruff
            installRuntimeDependencies = true; # Install python3
          };
          rust = {
            enable = true;
            installDependencies = true; # Install rust-analyzer, rustfmt
            installRuntimeDependencies = true; # Install rustc/cargo
          };
          scala = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          tex = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          toml = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          typst = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          yaml = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          zig = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
        };
        util = {
          gh = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
        };
      };

      # Additional packages (optional)
      extraPackages = with pkgs; [
        # Nix
        # nil # LSP
        # alejandra # Formatter
        statix # Linter

        # C/C++
        # clang-tools # C/C++ (clangd + clang-format)

        # Python
        python312Packages.pynvim
        basedpyright # LSP
        # ruff # Linter/formatter

        # Shell
        shfmt # Formatter

        # TeX
        pplatex # missing nixpkgs mappings for above tools:
        biber # Latex bibliography tool
        texliveMedium # LaTeX distribution with medium collection of packages
        ghostscript # LaTeX previewing
        texlab # LSP

        # Rust
        # rust-analyzer # LSP

        # Haskell
        # haskell-language-server # LSP
        # fourmolu # Formatter
        # hlint # Linter
        # haskellPackages.haskell-debug-adapter # Debug adapter

        # Markdown
        markdownlint-cli2 # Linter
        marksman # LSP

        # Lua
        lua51Packages.lua
        lua51Packages.luautf8
        lua51Packages.luarocks
        lua-language-server # LSP
        stylua # Formatter

        # Java
        # jdt-language-server # LSP

        # JSON
        vscode-json-languageserver # LSP

        # YAML
        yaml-language-server # LSP

        # Zig
        zls # LSP

        # Conform.nvim
        prettier
        prettierd

        # Stuff that checkhealth told me I needed
        unzip
        sqlite

        mermaid-cli
        icu
        imagemagick
        tree-sitter
      ];

      # Only needed for languages not covered by LazyVim extras
      treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        wgsl # WebGPU Shading Language
        templ # Go templ files

        # Snacks.image
        css
        scss
        svelte
        vue
      ];
    };
    home.shellAliases = {
      lazyvim = "NVIM_APPNAME=lazyvim nvim";
      pyright-langserver = "basedpyright-langserver";
    };
  };
}

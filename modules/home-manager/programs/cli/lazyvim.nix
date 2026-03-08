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
            installDependencies = true;
            installRuntimeDependencies = true;
          };
          nix = {
            enable = true;
            installDependencies = true; # nixd # Nix LSP # alejandra # Nix formatter
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
        # missing nixpkgs mappings for above tools:
        pplatex

        # Stuff that checkhealth told me I needed
        unzip
        sqlite
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

        biber
        texliveMedium

        # Language servers
        vscode-json-languageserver # JSON
        lua-language-server # Lua
        marksman # Markdown
        texlab # LaTeX
        yaml-language-server # YAML
        zls # Zig
        # nil # Nix
        # lua-language-server # Lua
        basedpyright # Python
        # ruff # Python (linter/formatter)
        # clang-tools # C/C++ (clangd + clang-format)
        # haskell-language-server # Haskell
        # haskellPackages.haskell-debug-adapter # Haskell
        # rust-analyzer # Rust
        # jdt-language-server # Java

        # Formatters
        stylua
        # alejandra # Nix formatter
        # fourmolu # Haskell

        # Linters
        statix # Nix
        # hlint # Haskell
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
  };
}

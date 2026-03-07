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
        nixd # Nix LSP
        alejandra # Nix formatter
      ];

      # Only needed for languages not covered by LazyVim extras
      treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        wgsl # WebGPU Shading Language
        templ # Go templ files
      ];
    };
  };
}

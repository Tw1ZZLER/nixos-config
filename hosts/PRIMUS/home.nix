# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # ./../../modules/home-manager # the default modules # okay maybe I don't understand this
    outputs.homeManagerModules.zen-browser
    outputs.homeManagerModules.xdg-user-dirs
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "tw1zzler";
    homeDirectory = "/home/tw1zzler";
  };

  # Add stuff for your user as you see fit:
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
  };
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Enable fonts
  fonts.fontconfig = {
    enable = true;
  };

  # NixGL settings
  nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs.unstable; [
    # Terminal
    (config.lib.nixGL.wrap wezterm)

    # Shell
    fish
    starship

    # Command utilities
    bat
    eza
    fd
    fzf
    ripgrep
    ugrep

    # Editor
    vscode

    # PDF Viewer
    zathura

    # Fonts
    nerd-fonts.victor-mono
    corefonts
    monocraft

    # Git
    lazygit

    # Terminal apps
    btop
    fastfetch
    yazi

    # Learning Languages
    exercism

    # Languages
    python3
    nodejs
    cargo
    rustc

    # Nix-specific
    nixfmt-rfc-style

    # Wine
    # wineWowPackages.staging
    # winetricks

    # Email / calendar
    thunderbird-bin

    # Waveforms
    # inputs.waveforms.packages.${system}.waveforms

    # Music stuff
    (config.lib.nixGL.wrap reaper) # WARN: Proprietary
    reaper-reapack-extension

    # Video stuff
    (config.lib.nixGL.wrap obs-studio)

    # Games
    (config.lib.nixGL.wrap moonlight-qt)
    (config.lib.nixGL.wrap steam) # WARN: Proprietary
    (config.lib.nixGL.wrap clonehero) # WARN: Proprietary

    # GUI apps that may or may not need hardware acceleration
    (config.lib.nixGL.wrap obsidian) # WARN: Proprietary
    (config.lib.nixGL.wrap discord) # WARN: Proprietary
    (config.lib.nixGL.wrap wpsoffice-cn) # WARN: Proprietary
    (config.lib.nixGL.wrap omnissa-horizon-client) # WARN: Proprietary

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

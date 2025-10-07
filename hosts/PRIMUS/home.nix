# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  outputs,
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
    # DEFAULTS for all systems
    ./../../modules/home-manager # the default modules # okay maybe I don't understand this
    # outputs.homeManagerModules.zen-browser
    # outputs.homeManagerModules.xdg-user-dirs
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

  #  Neovim
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [ unzip ];
    # extraLuaPackages = luaPkgs: with luaPkgs; [ luautf8 ];
    # extraPython3Packages = pyPkgs: with pyPkgs; [ pynvim ];
  };

  # VSCode
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.unstable.vscode;
  };

  xdg.configFile."nvim".source = ../../dotfiles/nvim;
  xdg.configFile."wezterm".source = ../../dotfiles/wezterm;
  xdg.configFile."fish".source = ../../dotfiles/fish;
  xdg.configFile."fastfetch".source = ../../dotfiles/fastfetch;
  xdg.configFile."yazi".source = ../../dotfiles/yazi;
  xdg.configFile."starship.toml".source = ../../dotfiles/starship.toml;

  # Wezterm
  # programs.wezterm = {
  #   enable = true;
  #   package = pkgs.unstable.wezterm;
  # };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Corbin";
    userEmail = "63320116+Tw1ZZLER@users.noreply.github.com";
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
    # overrideFolders = false; # can be used to turn off the auto restart thing
    # overrideDevices = false; # where devices and folders are deleted on switch
    settings = {
      options = {
        relaysEnabled = false;
        globalAnnounceEnabled = false;
        urAccepted = -1;
      };
      devices = {
        "Pixel 8" = {
          addresses = [ "tcp://100.67.233.82:22000" ];
          id = "K6ZAYPE-YSJ7ILX-2XARZW7-HVKS76J-7YSAJM5-7K6TQ7H-LHQ5U4A-4EPXOQR";
        };
        "iPad" = {
          addresses = [ "tcp://100.85.218.3:22000" ];
          id = "YJ74BBR-KYOX2GQ-WE6EPHY-WE6Y3DH-VEP6CFU-HATBP5G-U6VZMUS-BP4ALAA";
        };
        "REDMOND" = {
          addresses = [ "tcp://100.80.238.41:22000" ];
          id = "XVSUFJ6-DF5JJZU-ETJXMWT-XOFGOJ7-UJLGDLQ-MGMS2C3-HCJHTBM-F4E74QH";
        };
      };
      folders = {
        "Vaults" = {
          path = "/home/tw1zzler/vault";
          id = "ncpx4-79bk4";
          devices = [
            "REDMOND"
            "iPad"
            "Pixel 8"
          ];
        };
      };
    };
  };

  # Enable fonts
  fonts.fontconfig = {
    enable = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs.unstable; [
    # Terminal
    wezterm

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
    reaper # WARN: Proprietary
    reaper-reapack-extension

    # Video stuff
    obs-studio

    # Games
    moonlight-qt
    steam # WARN: Proprietary
    clonehero # WARN: Proprietary

    # GUI apps that may or may not need hardware acceleration
    obsidian # WARN: Proprietary
    discord # WARN: Proprietary
    wpsoffice-cn # WARN: Proprietary
    omnissa-horizon-client # WARN: Proprietary

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

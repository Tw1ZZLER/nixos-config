{
  self,
  inputs,
  ...
}: {
  flake.homeModules."tw1zzler@PRIMUS" = {...}: {
    imports = with self.homeModules; [
      # CLI Programs
      bat
      btop
      direnv
      exercism
      eza
      fastfetch
      fd
      fish
      fzf
      git
      neovim
      nix-helper
      nix-index
      python
      ripgrep
      rmpc
      sqlite
      starship
      wget
      yazi

      # GUI Programs
      ark
      clone-hero
      cursor
      discord
      dolphin
      filelight
      ghostty
      gwenview
      krita
      moonlight
      mpv
      obs-studio
      obsidian
      onu
      prismlauncher
      qbittorrent
      reaper
      research
      slack
      thunderbird
      twintail-launcher
      vscode
      xilinx
      ytmusic
      zathura
      zen-browser

      # TUI Programs
      opencode

      # Services
      fonts
      syncthing
      xdg-user-dirs
      stylix-wrapper

      # Desktop
      hyprland
      niri
      gnome-keyring
      noctalia-shell
    ];

    programs.home-manager.enable = true;

    home.username = "tw1zzler";
    home.homeDirectory = "/home/tw1zzler";

    # Must pass hostname to Syncthing wrapper on non-NixOS hosts
    syncthing.hostName = "PRIMUS";

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "25.05";
  };
}

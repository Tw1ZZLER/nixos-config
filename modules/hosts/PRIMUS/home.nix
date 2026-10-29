{
  self,
  inputs,
  ...
}: {
  flake.homeModules."tw1zzler@PRIMUS" = {...}: {
    imports = with self.homeModules; [
      # standard shell
      shell

      # music playa
      rmpc

      # GUI Programs
      # ark
      cursor
      discord
      dolphin
      ghostty
      gwenview
      # moonlight
      mpv
      # obs-studio
      obsidian
      # onu
      prismlauncher
      qbittorrent
      reaper
      slack
      thunderbird
      # twintail-launcher
      vscode
      # xilinx
      ytmusic
      zathura
      zen-browser
      zotero

      # TUI Programs
      opencode
      pi

      # Services
      flatpak
      fonts
      syncthing
      xdg-user-dirs
      stylix-wrapper

      # Desktop
      niri
      gnome-keyring
      noctalia-shell
    ];

    programs.home-manager.enable = true;

    home.username = "tw1zzler";
    home.homeDirectory = "/home/tw1zzler";

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "25.05";
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.homeModules."tw1zzler@REDMOND" = {...}: {
    imports = with self.homeModules; [
      # standard shell
      shell

      # music playa
      rmpc

      # GUI Programs
      cursor
      discord
      dolphin
      ghostty
      gwenview
      mpv
      obsidian
      prismlauncher
      qbittorrent
      reaper
      slack
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
      mpd
      syncthing
      xdg-user-dirs
      # stylix-wrapper

      # Desktop
      # gnome-keyring
      plasma
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

{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations."tw1zzler@REDMOND" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [self.homeModules."tw1zzler@REDMOND"];
  };

  flake.homeModules."tw1zzler@REDMOND" = {...}: {
    imports = with self.homeModules; [
      # Nixpkgs
      nixpkgs-config

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
      cursor
      discord
      ghostty
      mpv
      obsidian
      prismlauncher
      qbittorrent
      reaper
      slack
      ytmusic
      zathura
      zen-browser

      # TUI Programs
      opencode

      # Services
      fonts
      mpd
      generic-linux
      syncthing
      xdg-user-dirs
    ];

    programs.home-manager.enable = true;

    home.username = "tw1zzler";
    home.homeDirectory = "/home/tw1zzler";

    # Must pass hostname to Syncthing wrapper on non-NixOS hosts
    syncthing.hostName = "REDMOND";

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "25.05";
  };
}

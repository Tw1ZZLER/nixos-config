{
  self,
  inputs,
  ...
}: {
  flake.homeModules."tw1zzler@PRIMUS" = {...}: {
    imports = [
      # CLI Programs
      self.homeModules.bat
      self.homeModules.btop
      self.homeModules.direnv
      self.homeModules.exercism
      self.homeModules.eza
      self.homeModules.fastfetch
      self.homeModules.fd
      self.homeModules.fish
      self.homeModules.fzf
      self.homeModules.git
      self.homeModules.neovim
      self.homeModules.nix-helper
      self.homeModules.nix-index
      self.homeModules.python
      self.homeModules.ripgrep
      self.homeModules.rmpc
      self.homeModules.sqlite
      self.homeModules.starship
      self.homeModules.wget
      self.homeModules.yazi

      # GUI Programs
      self.homeModules.clone-hero
      self.homeModules.discord
      self.homeModules.ghostty
      self.homeModules.mpv
      self.homeModules.obsidian
      self.homeModules.onu
      self.homeModules.prismlauncher
      self.homeModules.qbittorrent
      self.homeModules.slack
      self.homeModules.xilinx
      self.homeModules.zathura
      self.homeModules.zen-browser

      # Services
      self.homeModules.fonts
      self.homeModules.syncthing
      self.homeModules.xdg-user-dirs
      self.homeModules.stylix-wrapper

      # Desktop
      self.homeModules.hyprland
      self.homeModules.niri
      self.homeModules.gnome-keyring
      self.homeModules.noctalia-shell
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

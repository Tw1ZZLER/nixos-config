{
  self,
  inputs,
  ...
}: {
  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations."tw1zzler@REDMOND" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules."tw1zzler@REDMOND"
      {
        home.username = "tw1zzler";
        home.homeDirectory = "/home/tw1zzler";
      }

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
      self.homeModules.discord
      self.homeModules.ghostty
      self.homeModules.prismlauncher
      self.homeModules.zen-browser

      # Services
      self.homeModules.nixgl
      self.homeModules.syncthing
      self.homeModules.xdg-user-dirs

      # Desktop
      self.homeModules.niri
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules."tw1zzler@REDMOND" = {pkgs, ...}: {
    home.packages = [
      pkgs.hello
    ];
    home.stateVersion = "25.05";
  };
}

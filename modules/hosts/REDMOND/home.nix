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
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules."tw1zzler@REDMOND" = {pkgs, ...}: {
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    home.packages = [
      pkgs.hello
      self.packages.myZen
    ];
    home.stateVersion = "24.11";
  };
}

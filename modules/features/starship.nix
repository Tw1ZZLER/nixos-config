{
  self,
  inputs,
  ...
}: {
  flake.homeModules.starship = {pkgs, ...}: {
    # Starship prompt
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;

      # Fish only settings
      enableFishIntegration = true;
      enableTransience = true;
      enableInteractive = true;

      package = pkgs.unstable.starship;
      presets = [
        "nerd-font-symbols"
      ];
    };
  };
}

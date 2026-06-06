{
  self,
  inputs,
  ...
}: {
  flake.homeModules.starship = {...}: {
    # Starship prompt
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;

      # Fish only settings
      enableFishIntegration = true;
      enableTransience = true;
      enableInteractive = true;

      presets = [
        "nerd-font-symbols"
      ];
    };
  };
}

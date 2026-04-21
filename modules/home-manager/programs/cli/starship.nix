{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    starship.enable = lib.mkEnableOption "Enable Starship prompt";
  };
  config = lib.mkIf config.starship.enable {
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

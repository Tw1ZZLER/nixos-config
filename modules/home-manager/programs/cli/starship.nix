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
      package = pkgs.unstable.starship;
      settings = (builtins.fromTOML (builtins.readFile ../../dotfiles/starship.toml));
    };
  };
}

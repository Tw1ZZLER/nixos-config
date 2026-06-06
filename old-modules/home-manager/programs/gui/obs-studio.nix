{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    obs-studio.enable = lib.mkEnableOption "Enable OBS Studio";
  };

  config = lib.mkIf config.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
      package = pkgs.unstable.obs-studio;
    };
  };
}

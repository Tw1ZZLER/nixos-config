{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ly.enable = lib.mkEnableOption "Enable the ly display manager";
  };
  config = lib.mkIf config.ly.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}

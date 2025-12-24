{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    yazi.enable = lib.mkEnableOption "Enable yazi, a modern terminal file manager";
  };

  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
    };
    xdg.configFile.yazi = {
      recursive = true;
      source = ../../../dotfiles/yazi;
    };
  };
}

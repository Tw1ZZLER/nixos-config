{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat, a cat clone with syntax highlighting and Git integration";
  };

  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      package = pkgs.unstable.bat;
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zathura.enable = pkgs.lib.mkEnableOption "Enable Zathura PDF viewer";
  };
  config = pkgs.lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
      package = pkgs.unstable.zathura;
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zathura.enable = lib.mkEnableOption "Enable Zathura PDF viewer";
  };
  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
      package = pkgs.unstable.zathura;
    };
  };
}

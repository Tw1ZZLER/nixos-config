{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    btop.enable = lib.mkEnableOption "Enable btop, a resource monitor terminal application";
  };

  config = lib.mkIf config.btop.enable {
    programs.btop = {
      enable = true;
      package = pkgs.unstable.btop;
      settings = {
        proc_tree = true;
        theme_background = false;
      };
    };
  };
}

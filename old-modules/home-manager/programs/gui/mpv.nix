{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    mpv.enable = lib.mkEnableOption "Enable MPV media player";
  };

  config = lib.mkIf config.mpv.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv;
    };
  };
}

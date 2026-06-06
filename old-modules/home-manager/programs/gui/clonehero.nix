{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    clonehero.enable = lib.mkEnableOption "Enable Clone Hero, a free rhythm game.";
  };

  config = lib.mkIf config.clonehero.enable {
    home.packages = with pkgs.unstable; [
      clonehero # WARN: Proprietary
    ];
  };
}

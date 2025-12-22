{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gwenview.enable = lib.mkEnableOption "Enable Gwenview, an image viewer for KDE.";
  };

  config = lib.mkIf config.gwenview.enable {
    home.packages = with pkgs.unstable; [
      kdePackages.gwenview
    ];
  };
}

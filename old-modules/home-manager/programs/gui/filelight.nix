{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    filelight.enable = lib.mkEnableOption "Enable Filelight, a disk usage analyzer for KDE.";
  };

  config = lib.mkIf config.filelight.enable {
    home.packages = with pkgs.unstable; [
      kdePackages.filelight
    ];
  };
}

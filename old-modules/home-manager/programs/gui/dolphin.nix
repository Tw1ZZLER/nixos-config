{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    dolphin.enable = lib.mkEnableOption "Enable Dolphin, a file manager for KDE.";
  };

  config = lib.mkIf config.dolphin.enable {
    home.packages = with pkgs.unstable; [
      kdePackages.dolphin
      kdePackages.qtsvg # For support for SVG icons
      kdePackages.kio # needed since 25.11
      kdePackages.kio-fuse # to mount remote filesystems via FUSE
      kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    ];
  };
}

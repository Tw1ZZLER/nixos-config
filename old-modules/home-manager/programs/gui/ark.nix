{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ark.enable = lib.mkEnableOption "Enable Ark, a file archiver and compressor for KDE.";
  };

  config = lib.mkIf config.ark.enable {
    home.packages = with pkgs.unstable; [
      kdePackages.ark
    ];
  };
}

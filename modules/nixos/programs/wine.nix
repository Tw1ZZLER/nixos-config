{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    wine.enable = lib.mkEnableOption "Enable Wine for running Windows applications";
  };
  config = lib.mkIf config.wine.enable {
    # It's better to use unstable for this sort of thing
    environment.systemPackages = with pkgs.unstable; [
      # Wine
      wineWowPackages.staging
      winetricks
      wineasio # JACK to ASIO driver
    ];
  };
}

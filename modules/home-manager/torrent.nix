# Torrenting client
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    torrent.enable = lib.mkEnableOption "Enable qBittorrent client";
  };
  config = lib.mkIf config.torrent.enable {
    home.packages = with pkgs.unstable; [
      qbittorrent
    ];
  };
}

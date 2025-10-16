# Torrenting client
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    qbittorrent
  ];
}

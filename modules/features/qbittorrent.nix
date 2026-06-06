# Torrenting client
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.qbittorrent = {pkgs, ...}: {
    home.packages = [pkgs.qbittorrent];
  };
}

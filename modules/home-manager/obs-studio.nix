# The best video recording and streaming software
{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    obs-studio
  ];
}

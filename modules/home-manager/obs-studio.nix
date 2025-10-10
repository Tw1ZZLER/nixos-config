{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    obs-studio
  ];
}

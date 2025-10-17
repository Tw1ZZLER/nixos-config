# The best video recording and streaming software
{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.unstable.obs-studio;
  };
}

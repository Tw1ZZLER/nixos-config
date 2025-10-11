# The best tool for language learning
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    exercism
  ];
}

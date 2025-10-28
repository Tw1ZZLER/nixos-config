{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    sqlite
  ];
}

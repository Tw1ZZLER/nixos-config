# (Proprietary) Communication platform
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    discord # WARN: Proprietary
  ];
}

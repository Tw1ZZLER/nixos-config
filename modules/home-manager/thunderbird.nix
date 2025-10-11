# Email /calendar
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    thunderbird-bin
  ];
}

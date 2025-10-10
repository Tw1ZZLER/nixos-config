{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    # Email /calendar
    thunderbird-bin
  ];
}

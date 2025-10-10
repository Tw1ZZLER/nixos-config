{ pkgs }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs.unstable.wezterm;
  };
}

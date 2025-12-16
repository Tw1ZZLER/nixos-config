# The best terminal emulator
{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs.unstable.wezterm;
  };

  # Wezterm configuration dotfiles
  # xdg.configFile.wezterm = {
  #   recursive = true;
  #   source = ../../dotfiles/wezterm;
  # };
}

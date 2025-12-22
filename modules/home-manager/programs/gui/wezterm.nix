# The best terminal emulator
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    wezterm.enable = lib.mkEnableOption "Enable Wezterm terminal emulator";
  };
  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.unstable.wezterm;
    };

    # Wezterm configuration dotfiles
    xdg.configFile.wezterm = {
      recursive = true;
      source = ../../../../dotfiles/wezterm;
    };
  };
}

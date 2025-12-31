# The best terminal emulator
{
  pkgs,
  lib,
  config,
  ...
}:
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/tw1zzler/nixos-config/dotfiles";
in
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
      source = "${dotfiles}/wezterm";
      recursive = true;
    };
  };
}

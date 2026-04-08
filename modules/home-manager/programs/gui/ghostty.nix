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
    ghostty.enable = lib.mkEnableOption "Enable Ghostty terminal emulator";
  };
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = pkgs.unstable.ghostty;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      systemd.enable = true;
    };

    # Ghostty configuration dotfiles
    # xdg.configFile.ghostty = {
    #   source = "${dotfiles}/ghostty";
    #   recursive = true;
    # };
  };
}

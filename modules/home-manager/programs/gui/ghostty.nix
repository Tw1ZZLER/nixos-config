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
      settings = {
        command = "/etc/profiles/per-user/tw1zzler/bin/fish --login --interactive";
        font-family = "VictorMono Nerd Font";
        font-size = 12;
        theme = "Catppuccin Frappe";
        background-opacity = 0.85;
      };
    };

    # Ghostty configuration dotfiles
    # xdg.configFile.ghostty = {
    #   source = "${dotfiles}/ghostty";
    #   recursive = true;
    # };
  };
}

# The best terminal emulator
{
  self,
  inputs,
  ...
}: {
  # Small module to replace package with nixGL wrapped package on non-NixOS systems
  flake.homeModules.ghostty-nixgl = {
    pkgs,
    config,
    ...
  }: {
    programs.ghostty.package = config.lib.nixGL.wrap pkgs.ghostty;
  };

  flake.homeModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      systemd.enable = true;
      settings = {
        command = "${pkgs.fish}/bin/fish --login --interactive";
        font-family = "VictorMono Nerd Font";
        font-size = 12;
        theme = "Catppuccin Frappe";
        background-opacity = 0.85;
        quit-after-last-window-closed = false;
      };
    };
  };
}

# The best terminal emulator
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.ghostty = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
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
        quit-after-last-window-closed = false;
      };
    };
  };
}

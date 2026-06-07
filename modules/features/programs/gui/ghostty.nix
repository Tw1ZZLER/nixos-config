# The best terminal emulator
{
  self,
  inputs,
  ...
}: {
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

{
  self,
  inputs,
  ...
}: {
  flake.homeModules.git = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Corbin";
          email = "63320116+Tw1ZZLER@users.noreply.github.com";
        };
      };
      signing = {
        format = "ssh";
        key = "/home/tw1zzler/.ssh/github_signing.pub";
        signByDefault = true;
      };
    };

    programs.lazygit = {
      enable = true;
      settings.git.overrideGpg = true;
    };

    home.packages = with pkgs; [
      gh # GitHub CLI
      codeberg-cli # gh-like tool for Codeberg
    ];
  };
}

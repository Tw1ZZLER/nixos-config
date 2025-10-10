# Configure git and other git-related tools
{ pkgs }:
{
  programs.git = {
    enable = true;
    userName = "Corbin";
    userEmail = "63320116+Tw1ZZLER@users.noreply.github.com";
  };

  home.packages = with pkgs.unstable; [
    lazygit
  ];
}

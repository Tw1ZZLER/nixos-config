# Configure git and other git-related tools
{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Corbin";
        email = "63320116+Tw1ZZLER@users.noreply.github.com";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    package = pkgs.unstable.lazygit;
  };

  home.packages = with pkgs.unstable; [
    gh
  ];
}

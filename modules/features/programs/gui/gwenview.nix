# Enable Gwenview, an image viewer for KDE
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.gwenview = {pkgs, ...}: {
    home.packages = [pkgs.kdePackages.gwenview];
  };
}

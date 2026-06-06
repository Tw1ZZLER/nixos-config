# Enable Filelight, a disk usage analyzer for KDE.
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.filelight = {pkgs, ...}: {
    home.packages = [pkgs.kdePackages.filelight];
  };
}

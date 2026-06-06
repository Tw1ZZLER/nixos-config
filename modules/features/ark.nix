# Enable Ark, a file archiver and compressor for KDE.
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.ark = {pkgs, ...}: {
    home.packages = [pkgs.kdePackages.ark];
  };
}

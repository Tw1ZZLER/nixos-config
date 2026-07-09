# Enable Krita, a professional digital painting application
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.krita = {pkgs, ...}: {
    home.packages = [pkgs.krita];
  };
}

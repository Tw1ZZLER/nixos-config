# Pear desktop (alternative YouTube Music client for Linux) + Pano scrobbler  (Scrobbler that supports Libre.fm)
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.ytmusic = {pkgs, ...}: {
    home.packages = [
      pkgs.pear-desktop
      inputs.pano-scrobbler.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

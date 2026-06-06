# Enable Twintail Launcher, a free and open-source launcher for your anime games
# Uses my flake for packaging Twintail Launcher
# Ideally maybe will get merged into nixpkgs?
# Or flake will be provided by original Twintail Launcher repository
# https://github.com/Tw1ZZLER/twintail-launcher-flake
{
  self,
  inputs,
  ...
}: {
  # Small module to replace package with nixGL wrapped package on non-NixOS systems
  flake.homeModules.twintail-launcher-nixgl = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [
      (config.lib.nixGL.wrap inputs.twintail-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default)
    ];
  };

  flake.homeModules.twintail-launcher = {pkgs, ...}: {
    home.packages = [
      inputs.twintail-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

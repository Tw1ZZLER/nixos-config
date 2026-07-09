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
  flake.homeModules.twintail-launcher = {pkgs, ...}: {
    home.packages = [
      inputs.twintail-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

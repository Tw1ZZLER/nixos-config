# Uses my flake for packaging Twintail Launcher
# Ideally maybe will get merged into nixpkgs?
# Or flake will be provided by original Twintail Launcher repository
# https://github.com/Tw1ZZLER/twintail-launcher-flake
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  options = {
    twintail-launcher.enable = lib.mkEnableOption "Enable Twintail Launcher, a free and open-source launcher for your anime games";
  };

  config = lib.mkIf config.twintail-launcher.enable {
    home.packages = [
      inputs.twintail-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

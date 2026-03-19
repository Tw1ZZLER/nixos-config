# https://github.com/DragonHuntrX/waveforms-flake-local
# Absolute gigachad uploaded the .deb files directly to GitHub
{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options = {
    waveforms.enable = mkEnableOption "Enable Digilent Waveforms";
  };

  config = mkIf config.waveforms.enable {
    nixpkgs.overlays = [ inputs.waveforms.overlay ];

    services.udev.packages = [ pkgs.adept2-runtime ];
    environment.systemPackages = [ pkgs.waveforms ];

    users.users.tw1zzler.extraGroups = [ "plugdev" ];
  };
}

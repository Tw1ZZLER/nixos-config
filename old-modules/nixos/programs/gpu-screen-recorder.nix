# https://wiki.nixos.org/wiki/Gpu-screen-recorder
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gpu-screen-recorder.enable = lib.mkEnableOption "Enable GPU screen recorder";
  };
  config = lib.mkIf config.gpu-screen-recorder.enable {
    programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GUI

    environment.systemPackages = with pkgs; [
      gpu-screen-recorder # CLI tool (needed by Noctalia screen-recorder widget)
      gpu-screen-recorder-gtk # GUI app
    ];
  };
}

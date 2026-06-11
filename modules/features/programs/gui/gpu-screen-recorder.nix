# Enable GPU screen recorderj
# https://wiki.nixos.org/wiki/Gpu-screen-recorder
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.gpu-screen-recorder = {pkgs, ...}: {
    programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GUI
    environment.systemPackages = with pkgs; [
      gpu-screen-recorder # CLI tool (needed by Noctalia screen-recorder widget)
      gpu-screen-recorder-gtk # GUI app
    ];
  };
}

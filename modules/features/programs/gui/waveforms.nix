# https://github.com/DragonHuntrX/waveforms-flake-local
# Absolute gigachad uploaded the .deb files directly to GitHub
# Enable Digilent Waveforms
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.waveforms = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.waveforms.overlay];
    services.udev.packages = [pkgs.adept2-runtime];
    environment.systemPackages = [pkgs.waveforms];
    users.users.tw1zzler.extraGroups = ["plugdev"];
  };
}

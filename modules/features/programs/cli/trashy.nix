# Enable Trashy application for managing the trash bin
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.trashy = {pkgs, ...}: {
    environment.systemPackages = [pkgs.trashy];
  };
}

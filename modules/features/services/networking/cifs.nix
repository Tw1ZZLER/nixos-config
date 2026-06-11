# Enable CIFS utilities for mounting SMB/CIFS shares
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cifs = {pkgs, ...}: {
    # For mount.cifs, required unless domain name resolution is not needed.
    environment.systemPackages = [pkgs.cifs-utils];
  };
}

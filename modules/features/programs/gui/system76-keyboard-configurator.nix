# Enable system76-keyboard-configurator app
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.system76-keyboard-configurator = {pkgs, ...}: {
    environment.systemPackages = [pkgs.system76-keyboard-configurator];
  };
}

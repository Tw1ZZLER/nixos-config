# Enable machine to emulate aarch64 to build packages
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.build-system-aarch64 = {...}: {
    boot.binfmt.emulatedSystems = ["aarch64-linux"];
  };
}

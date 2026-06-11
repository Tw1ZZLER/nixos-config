# Enable Seahorse for managing encryption keys
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.seahorse = {...}: {
    programs.seahorse.enable = true;
  };
}

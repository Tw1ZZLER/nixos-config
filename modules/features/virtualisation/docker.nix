# Enable Docker containerization platform
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.docker = {...}: {
    virtualisation.docker.enable = true;
    users.users.tw1zzler.extraGroups = ["docker"];
  };
}

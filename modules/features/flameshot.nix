# Enable Flameshot screenshot tool
# Not needed if compositor has a screenshot tool
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.flameshot = {...}: {
    services.flameshot.enable = true;
  };
}

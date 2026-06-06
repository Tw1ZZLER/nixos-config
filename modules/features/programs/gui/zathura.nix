# Enable Zathura PDF viewer
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zathura = {...}: {
    programs.zathura.enable = true;
  };
}

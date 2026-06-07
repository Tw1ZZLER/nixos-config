# The best personal knowledge management system (its proprietary unfortunately)
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.obsidian = {...}: {
    programs.obsidian.enable = true;
  };
}

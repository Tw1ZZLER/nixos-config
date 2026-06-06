{
  self,
  inputs,
  ...
}: {
  flake.homeModules.eza = {...}: {
    programs.eza.enable = true;
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.homeModules.fzf = {...}: {
    programs.fzf.enable = true;
  };
}

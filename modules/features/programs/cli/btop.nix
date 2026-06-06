{
  self,
  inputs,
  ...
}: {
  flake.homeModules.btop = {...}: {
    programs.btop = {
      enable = true;
      settings = {
        proc_tree = true;
        theme_background = false;
      };
    };
  };
}

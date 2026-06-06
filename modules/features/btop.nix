{
  self,
  inputs,
  ...
}: {
  flake.homeModules.btop = {pkgs, ...}: {
    programs.btop = {
      enable = true;
      settings = {
        proc_tree = true;
        theme_background = false;
      };
    };
  };
}

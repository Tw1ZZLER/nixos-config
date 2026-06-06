{
  self,
  inputs,
  ...
}: {
  flake.homeModules.btop = {pkgs, ...}: {
    programs.btop = {
      enable = true;
      package = pkgs.unstable.btop;
      settings = {
        proc_tree = true;
        theme_background = false;
      };
    };
  };
}

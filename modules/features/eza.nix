{
  self,
  inputs,
  ...
}: {
  flake.homeModules.eza = {pkgs, ...}: {
    programs.eza = {
      enable = true;
      package = pkgs.eza;
    };
  };
}

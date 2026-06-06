{
  self,
  inputs,
  ...
}: {
  flake.homeModules.sqlite = {pkgs, ...}: {
    home.packages = [pkgs.sqlite];
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.homeModules.exercism = {pkgs, ...}: {
    home.packages = [pkgs.exercism];
  };
}

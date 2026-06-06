{
  self,
  inputs,
  ...
}: {
  flake.homeModules.wget = {pkgs, ...}: {
    home.packages = [pkgs.wget];
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.homeModules.exercism = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      exercism
    ];
  };
}

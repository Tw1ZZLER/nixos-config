{
  self,
  inputs,
  ...
}: {
  flake.homeModules.wget = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      wget
    ];
  };
}

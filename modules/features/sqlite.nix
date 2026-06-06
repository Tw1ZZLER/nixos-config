{
  self,
  inputs,
  ...
}: {
  flake.homeModules.sqlite = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      sqlite
    ];
  };
}

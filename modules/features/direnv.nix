# Enable direnv, an environment switcher for the shell
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.direnv = {pkgs, ...}: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.package = pkgs.nix-direnv;
    };
  };
}

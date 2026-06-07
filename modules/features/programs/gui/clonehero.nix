# Enable Clone Hero, a free rhythm game
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.clone-hero = {pkgs, ...}: {
    # WARN: Proprietary
    home.packages = [pkgs.clonehero];
  };
}

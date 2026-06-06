# Enable Clone Hero, a free rhythm game
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.clone-hero-nixgl = {
    pkgs,
    config,
    ...
  }: {
    # WARN: Proprietary
    home.packages = [(config.lib.nixGL.wrap pkgs.clonehero)];
  };

  flake.homeModules.clone-hero = {pkgs, ...}: {
    # WARN: Proprietary
    home.packages = [pkgs.clonehero];
  };
}

# The best personal knowledge management system (its proprietary unfortunately)
{
  self,
  inputs,
  ...
}: {
  # Small module to replace package with nixGL wrapped package on non-NixOS systems
  flake.homeModules.obsidian-nixgl = {
    pkgs,
    config,
    ...
  }: {
    programs.obsidian.package = config.lib.nixGL.wrap pkgs.obsidian;
  };

  flake.homeModules.obsidian = {...}: {
    programs.obsidian.enable = true;
  };
}

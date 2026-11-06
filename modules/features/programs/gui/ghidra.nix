# Ghidra, reverse engineering toolkit
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.ghidra = {pkgs, ...}: {
    home.packages = [pkgs.ghidra];
  };
}

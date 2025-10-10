# The best personal knowledge management system (its proprietary unfortunately)
{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    obsidian # WARN: Proprietary
  ];
}

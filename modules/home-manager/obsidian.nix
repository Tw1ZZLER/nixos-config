{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    obsidian # WARN: Proprietary
  ];
}

# Gaming tools, games, etc.
{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    moonlight-qt
    steam # WARN: Proprietary
    clonehero # WARN: Proprietary
    prismlauncher
  ];
}

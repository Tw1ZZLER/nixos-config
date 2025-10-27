# Gaming tools, games, etc.
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    moonlight-qt
    clonehero # WARN: Proprietary
    steam # WARN: Proprietary
    prismlauncher
  ];
}

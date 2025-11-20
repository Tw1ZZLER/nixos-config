# Not the best text editor, but necessary in many cases
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    vscode.fhs
  ];
}

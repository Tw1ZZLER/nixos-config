# Not the best text editor, but necessary in many cases
{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode.fhs;
  };
}

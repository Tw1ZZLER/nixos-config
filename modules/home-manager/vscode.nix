# Not the best text editor, but necessary in many cases
{ pkgs }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
    };
    package = pkgs.unstable.vscode;
  };
}

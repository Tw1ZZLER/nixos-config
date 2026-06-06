# Not the best text editor, but necessary in many cases
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.vscode = {pkgs, ...}: {
    home.packages = [pkgs.vscode.fhs];
  };
}

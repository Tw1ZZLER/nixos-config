{ pkgs }:
{
  # VSCode
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
    };
    package = pkgs.unstable.vscode;
  };
}

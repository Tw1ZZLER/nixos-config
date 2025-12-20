# Not the best text editor, but necessary in many cases
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    vscode.enable = lib.mkEnableOption "Enable VSCode FHS version";
  };

  config = lib.mkIf config.vscode.enable {
    home.packages = with pkgs.unstable; [
      vscode.fhs
    ];
  };
}

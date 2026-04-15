# Slack client
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options = {
    slack.enable = mkEnableOption "Enable Slack client";
  };

  config = mkIf config.slack.enable {
    home.packages = with pkgs.unstable; [
      slack
    ];
  };
}

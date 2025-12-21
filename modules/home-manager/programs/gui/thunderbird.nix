# Email /calendar
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    thunderbird.enable = lib.mkEnableOption "Enable Thunderbird email client";
  };

  config = lib.mkIf config.thunderbird.enable {
    home.packages = with pkgs.unstable; [
      thunderbird-bin
    ];
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    wget.enable = lib.mkEnableOption "Enable Wget, a command-line utility for downloading files from the web.";
  };

  config = lib.mkIf config.wget.enable {
    home.packages = with pkgs.unstable; [
      wget
    ];
  };
}

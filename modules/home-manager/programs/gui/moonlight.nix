{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    moonlight.enable = lib.mkEnableOption "Enable Moonlight, a game streaming client.";
  };

  config = lib.mkIf config.moonlight.enable {
    home.packages = with pkgs.unstable; [
      moonlight-qt
    ];
  };
}

# Steam options
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    steam.enable = lib.mkEnableOption "Enable Steam gaming platform";
  };
  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      package = pkgs.unstable.steam;
      protontricks = {
        enable = true;
        package = pkgs.unstable.protontricks;
      };
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs.unstable; [
        proton-ge-bin
      ];
    };
  };
}

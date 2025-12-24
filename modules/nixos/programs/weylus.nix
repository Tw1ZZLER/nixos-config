{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    weylus.enable = lib.mkEnableOption "Enable Weylus screen sharing application";
  };
  config = lib.mkIf config.weylus.enable {
    programs.weylus = {
      enable = true;
      openFirewall = true;
      users = [ "tw1zzler" ];
    };
  };
}

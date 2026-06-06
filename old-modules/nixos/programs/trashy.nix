{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    trashy.enable = lib.mkEnableOption "Enable Trashy application for managing the trash bin";
  };
  config = lib.mkIf config.trashy.enable {
    environment.systemPackages = with pkgs; [
      trashy
    ];
  };
}

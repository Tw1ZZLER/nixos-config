{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    krita.enable = lib.mkEnableOption "Enable Krita, a professional digital painting application.";
  };

  config = lib.mkIf config.krita.enable {
    home.packages = with pkgs.unstable; [
      krita
    ];
  };
}

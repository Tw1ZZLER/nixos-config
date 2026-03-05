{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    system76-keyboard-configurator.enable = lib.mkEnableOption "Enable System76 Keyboard Configurator app";
  };
  config = lib.mkIf config.system76-keyboard-configurator.enable {
    environment.systemPackages = with pkgs; [
      system76-keyboard-configurator
    ];
  };
}

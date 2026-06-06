{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    pipewire.enable = lib.mkEnableOption "Enable sound service with PipeWire";
  };

  config = lib.mkIf config.pipewire.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}

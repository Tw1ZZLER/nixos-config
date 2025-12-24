{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sound.enable = lib.mkEnableOption "Enable sound service with PulseAudio and ALSA";
  };

  config = lib.mkIf config.sound.enable {
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

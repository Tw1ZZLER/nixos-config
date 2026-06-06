{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    flameshot.enable = lib.mkEnableOption "Enable Flameshot screenshot tool";
  };

  config = lib.mkIf config.flameshot.enable {
    services.flameshot = {
      enable = true;
      package = pkgs.unstable.flameshot;
    };
  };
}

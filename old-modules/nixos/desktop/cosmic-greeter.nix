{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cosmic-greeter.enable = lib.mkEnableOption "Enable the COSMIC greeter login manager";
  };
  config = lib.mkIf config.cosmic-greeter.enable {
    # Enable the COSMIC login manager
    services = {
      displayManager = {
        cosmic-greeter = {
          enable = true;
        };
        autoLogin = {
          enable = true;
          user = "tw1zzler";
        };
      };
    };
  };
}

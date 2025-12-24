{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    tailscale.enable = lib.mkEnableOption "Enable Tailscale VPN service";
  };

  config = lib.mkIf config.tailscale.enable {
    services.tailscale.enable = true;
  };
}

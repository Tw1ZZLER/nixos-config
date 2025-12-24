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

  config = lib.mkIf config.stylix-wrapper.enable {
    services.tailscale.enable = true;
  };
}

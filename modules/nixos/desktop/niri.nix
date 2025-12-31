{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    niri.enable = lib.mkEnableOption "Enable the Niri window manager";
  };
  config = lib.mkIf config.niri.enable {
    programs.niri.enable = true;

    environment = {
      sessionVariables = {
        # Wayland support for Electron and Chromium
        NIXOS_OZONE_WL = "1";
      };
      systemPackages = with pkgs; [
        # Other Wayland clipboard stuff
        wl-clipboard
        cliphist

        # Xwayland support
        xwayland-satellite
      ];
    };
  };
}

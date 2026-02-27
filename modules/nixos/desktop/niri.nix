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

    # Portal configuration for screen sharing, file dialogs, etc.
    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome # Screen sharing portal for Niri
        xdg-desktop-portal-gtk # Fallback portal for file dialogs and other interfaces
      ];
    };

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

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable the Hyprland window manager";
  };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true; # to be honest I wish I knew why this doesn't work but I don't right now know!
    };

    # Portal configuration for screen sharing, file dialogs, etc.
    xdg.portal = {
      extraPortals = with pkgs; [
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

        # required for the default Hyprland config
        kitty
      ];
    };
  };
}

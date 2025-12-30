{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cosmic.enable = lib.mkEnableOption "Enable the COSMIC desktop environment";
  };
  config = lib.mkIf config.cosmic.enable {
    services.desktopManager.cosmic.enable = true;

    environment = {
      sessionVariables = {
        # Fix Wayland clipboard (decreases security)
        COSMIC_DATA_CONTROL_ENABLED = 1;
        # Wayland support for Electron and Chromium
        NIXOS_OZONE_WL = "1";
      };
      systemPackages = with pkgs; [
        # Other Wayland clipboard stuff
        wl-clipboard
        cliphist
      ];

      # Exclude certain applications
      cosmic.excludePackages = with pkgs; [
        cosmic-player
      ];
    };
  };
}

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
    # Enable Seahorse for keyring management
    programs.seahorse.enable = true;

    # Enable the COSMIC login manager
    services = {
      displayManager = {
        cosmic-greeter = {
          enable = true;
          package = pkgs.unstable.cosmic-greeter;
        };
        autoLogin = {
          enable = true;
          user = "tw1zzler";
        };
      };

      # Enable the COSMIC desktop environment
      desktopManager.cosmic.enable = true;
    };

    environment = {
      sessionVariables = {
        # Fix Wayland clipboard (decreases security)
        COSMIC_DATA_CONTROL_ENABLED = 1;
        # Wayland support for Electron and Chromium
        NIXOS_OZONE_WL = "1";
        # Fix COSMIC Screenshot
        XDG_CURRENT_DESKTOP = "COSMIC";
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

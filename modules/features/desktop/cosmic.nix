# Enable the COSMIC desktop environment
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cosmic = {pkgs, ...}: {
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

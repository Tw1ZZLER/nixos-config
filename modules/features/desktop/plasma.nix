# Enable KDE Plasma desktop environment
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6.enable = true;

    # # Portal configuration for screen sharing, file dialogs, etc.
    # # system-level portal is needed for secrets
    # xdg.portal = {
    #   enable = true;
    #   extraPortals = with pkgs; [
    #     kdePackages.xdg-desktop-portal-kde
    #   ];
    #   config = let
    #     common = {
    #       default = [
    #         "gnome"
    #         "gtk"
    #       ];
    #       "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
    #     };
    #   in {
    #     inherit common;
    #     niri = common;
    #   };
    #   configPackages = [pkgs.niri];
    # };

    environment = {
      variables = {
        # Xwayland-satellite
        # DISPLAY = ":0";
        # Wayland support for Electron and Chromium
        NIXOS_OZONE_WL = "1";
        # Fix icon theming
        # QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      systemPackages = with pkgs; [
        # Other Wayland clipboard stuff
        wl-clipboard
        cliphist

        # Xwayland support
        xwayland-satellite
        xdg-utils
        qt6.qtwayland
        wayland
      ];
    };
  };

  # Plasma-manager configuration
  flake.homeModules.plasma = {...}: {};
}

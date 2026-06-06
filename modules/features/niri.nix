# Enable the Niri window manager
# I took quite a bit of this from https://codeberg.org/kiara/dots/src/branch/main/system/niri/default.nix
# Thank you!!
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri.enable = true;

    # Portal configuration for screen sharing, file dialogs, etc.
    # system-level portal is needed for secrets
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome # Screen sharing portal
        xdg-desktop-portal-gtk # Fallback portal for file dialogs and other interfaces
      ];
      config = let
        common = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
      in {
        inherit common;
        niri = common;
      };
      configPackages = [pkgs.niri];
    };

    systemd.packages = [pkgs.xwayland-satellite];

    environment = {
      variables = {
        # Xwayland-satellite
        DISPLAY = ":0";
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
        alacritty # in case of non-parsing config
        fuzzel
      ];
    };
  };

  # All this does is place the Niri config.kdl file
  flake.homeModules.niri = {lib, ...}: let
    dotfiles = lib.file.mkOutOfStoreSymlink "/home/tw1zzler/nixos-config/dotfiles";
  in {
    xdg.configFile."niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
  };
}

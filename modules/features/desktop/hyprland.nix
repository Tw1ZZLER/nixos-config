{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
    programs.hyprland = {
      enable = true;
      withUWSM = true; # to be honest I wish I knew why this doesn't work but I don't right now know!
    };

    # Portal configuration for screen sharing, file dialogs, etc.
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome # Screen sharing portal
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

  # Links Hyprland configuration file
  flake.homeModules.hyprland = {config, ...}: let
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/tw1zzler/nixos-config/dotfiles";
  in {
    xdg.configFile."hypr/hyprland.conf".source = "${dotfiles}/hypr/hyprland.conf";
  };
}

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
      withUWSM = true;
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
      ];
    };
  };
}

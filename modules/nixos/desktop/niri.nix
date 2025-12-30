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
    # Enable Seahorse for keyring management
    programs.seahorse.enable = true;

    # Enable Niri
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
      ];
    };
  };
}

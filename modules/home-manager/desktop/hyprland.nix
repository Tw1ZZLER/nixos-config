{
  config,
  lib,
  ...
}:
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/tw1zzler/nixos-config/dotfiles";
in
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland configuration (as an extension to NixOS module)";
  };
  config = lib.mkIf config.hyprland.enable {
    # Putting the dotfiles in their rightful place.
    xdg.configFile = {
      "hypr/hyprland.conf".source = "${dotfiles}/hypr/hyprland.conf";
    };
  };

}

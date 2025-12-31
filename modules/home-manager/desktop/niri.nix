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
    niri.enable = lib.mkEnableOption "Enable Niri configuration (as an extension to NixOS module)";
  };
  config = lib.mkIf config.niri.enable {
    # Putting the dotfiles in their rightful place.
    xdg.configFile."niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
  };

}

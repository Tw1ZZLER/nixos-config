{
  self,
  inputs,
  ...
}: {
  # Links Hyprland configuration file
  flake.homeModules.hyprland = {config, ...}: let
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/tw1zzler/nixos-config/dotfiles";
  in {
    xdg.configFile."hypr/hyprland.conf".source = "${dotfiles}/hypr/hyprland.conf";
  };
}

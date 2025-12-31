{ lib, ... }@args:
{
  imports = [
    ./hyprland.nix
    ./niri.nix
    ./noctalia-shell.nix
  ];

  noctalia-shell.enable = lib.mkIf (args ? osConfig) (
    lib.mkDefault (args.osConfig.hyprland.enable || args.osConfig.niri.enable)
  );
  hyprland.enable = lib.mkIf (args ? osConfig) (lib.mkDefault args.osConfig.hyprland.enable);
  niri.enable = lib.mkIf (args ? osConfig) (lib.mkDefault args.osConfig.niri.enable);
}

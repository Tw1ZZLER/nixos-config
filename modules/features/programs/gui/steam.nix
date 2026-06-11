# Enable Steam gaming platform
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        # Fixes black screen issues on Wayland
        # https://github.com/Supreeeme/xwayland-satellite/issues/150
        extraArgs = "-system-composer";
      };
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}

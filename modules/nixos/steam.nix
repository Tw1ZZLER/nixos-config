# Steam options
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.unstable.steam;
    protontricks = {
      enable = true;
      package = pkgs.unstable.protontricks;
    };
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs.unstable; [
      proton-ge-bin
    ];
  };
}

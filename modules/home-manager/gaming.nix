# Gaming tools, games, etc.
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    moonlight-qt
    clonehero # WARN: Proprietary
    prismlauncher
  ];

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
      mangohud
      gamemode
      vkbasalt
      lib32-mangohud
      lib32-gamemode
      lib32-vkbasalt
    ];
  };
}

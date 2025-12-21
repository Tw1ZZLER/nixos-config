{ lib, ... }:
{
  imports = [
    ./clonehero.nix
    ./discord.nix
    ./flameshot.nix
    ./moonlight.nix
    ./mpv.nix
    ./obs-studio.nix
    ./obsidian.nix
    ./onu.nix
    ./prismlauncher.nix
    ./reaper.nix
    ./research.nix
    ./thunderbird.nix
    ./torrent.nix
    ./vscode.nix
    ./wezterm.nix
    ./zathura.nix
    ./zen-browser.nix
  ];

  clonehero.enable = lib.mkDefault true;
  discord.enable = lib.mkDefault true;
  flameshot.enable = lib.mkDefault true;
  moonlight.enable = lib.mkDefault true;
  mpv.enable = lib.mkDefault true;
  obs-studio.enable = lib.mkDefault true;
  obsidian.enable = lib.mkDefault true;
  onu.enable = lib.mkDefault true;
  prismlauncher.enable = lib.mkDefault true;
  reaper.enable = lib.mkDefault true;
  research.enable = lib.mkDefault true;
  thunderbird.enable = lib.mkDefault true;
  torrent.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
  zen-browser.enable = lib.mkDefault true;
}

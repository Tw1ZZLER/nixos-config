{ lib, ... }@args:
{
  imports = [
    ./ark.nix
    ./clonehero.nix
    ./discord.nix
    ./filelight.nix
    ./flameshot.nix
    ./gwenview.nix
    ./moonlight.nix
    ./mpv.nix
    ./noctalia-shell.nix
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

  ark.enable = lib.mkDefault true;
  clonehero.enable = lib.mkDefault true;
  discord.enable = lib.mkDefault true;
  filelight.enable = lib.mkDefault true;
  flameshot.enable = lib.mkDefault true;
  gwenview.enable = lib.mkDefault true;
  moonlight.enable = lib.mkDefault true;
  mpv.enable = lib.mkDefault true;
  noctalia-shell.enable = lib.mkDefault (args.osConfig.hyprland.enable || args.osConfig.niri.enable);
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

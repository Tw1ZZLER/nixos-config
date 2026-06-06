{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./ark.nix
    ./clonehero.nix
    ./discord.nix
    ./dolphin.nix
    ./filelight.nix
    ./flameshot.nix
    ./ghostty.nix
    ./gwenview.nix
    ./krita.nix
    ./moonlight.nix
    ./mpv.nix
    ./obs-studio.nix
    ./obsidian.nix
    ./onu.nix
    ./prismlauncher.nix
    ./reaper.nix
    ./research.nix
    ./slack.nix
    ./thunderbird.nix
    ./torrent.nix
    ./twintail-launcher.nix
    ./vscode.nix
    ./xilinx.nix
    ./zathura.nix
    ./zen-browser.nix
  ];

  ark.enable = mkDefault true;
  clonehero.enable = mkDefault true;
  discord.enable = mkDefault true;
  dolphin.enable = mkDefault true;
  filelight.enable = mkDefault true;
  flameshot.enable = mkDefault false; # Only needed if compositor has no screenshot feature
  ghostty.enable = mkDefault true;
  gwenview.enable = mkDefault true;
  krita.enable = mkDefault true;
  moonlight.enable = mkDefault true;
  mpv.enable = mkDefault true;
  obs-studio.enable = mkDefault true;
  obsidian.enable = mkDefault true;
  onu.enable = mkDefault false;
  prismlauncher.enable = mkDefault true;
  reaper.enable = mkDefault true;
  research.enable = mkDefault true;
  slack.enable = mkDefault false;
  thunderbird.enable = mkDefault true;
  torrent.enable = mkDefault true;
  twintail-launcher.enable = mkDefault true;
  vscode.enable = mkDefault true;
  xilinx.enable = mkDefault false; # Only enable if doing FPGA development
  zathura.enable = mkDefault true;
  zen-browser.enable = mkDefault true;
}

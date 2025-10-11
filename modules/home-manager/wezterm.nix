# The best terminal emulator
{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs.unstable.wezterm;
  };

  # Just putting this terminal stuff here for now
  home.packages = with pkgs.unstable; [
    # Shell
    fish
    starship

    # Command utilities
    bat
    eza
    fd
    fzf
    ripgrep
    ugrep

    # Terminal apps
    btop
    fastfetch
    yazi
  ];
}

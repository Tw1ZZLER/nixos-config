{ pkgs, ... }:
{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.unstable.ncmpcpp;
    settings = {
      # MPD server (over Tailscale)
      mpd_host = "100.80.238.41";
      mpd_port = "6600";

      # UI sanity
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      progressbar_look = "━━";
    };
  };
  home.packages = with pkgs.unstable; [
    mpc
  ];
}

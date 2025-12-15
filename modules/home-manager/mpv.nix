{ pkgs, ... }:

let
  # CHANGE THIS to your desktop's Tailscale IP
  mpdStreamUrl = "http://100.80.238.41:8000";
in
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
  };

  # systemd.user.services.mpv-mpd-stream = {
  #   Unit = {
  #     Description = "MPV playing MPD HTTP stream";
  #     After = [ "network-online.target" ];
  #     Wants = [ "network-online.target" ];
  #   };
  #
  #   Service = {
  #     ExecStart = ''
  #       ${pkgs.mpv}/bin/mpv \
  #         --no-video \
  #         --cache=yes \
  #         --cache-secs=10 \
  #         --network-timeout=10 \
  #         --idle=no \
  #         ${mpdStreamUrl}
  #     '';
  #
  #     Restart = "always";
  #     RestartSec = 3;
  #
  #     # Clean shutdown
  #     KillSignal = "SIGTERM";
  #   };
  #
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };
}

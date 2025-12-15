{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;

    # MPD package
    package = pkgs.mpd;

    # Music library
    musicDirectory = "/home/tw1zzler/media/music";

    # MPD state / database location
    dataDir = "${config.xdg.cacheHome}/mpd";
    playlistDirectory = "${config.xdg.configHome}/mpd/playlists";

    network = {
      listenAddress = "0.0.0.0";
      port = 6600;
      startWhenNeeded = false;
    };

    # Everything MPD-specific goes here
    extraConfig = ''
      ############################
      # Logging / state
      ############################
      state_file   "${config.xdg.cacheHome}/mpd/state"
      sticker_file "${config.xdg.cacheHome}/mpd/sticker.sql"
      log_file     "${config.xdg.cacheHome}/mpd/log"

      ############################
      # Database
      ############################
      auto_update "yes"
      auto_update_depth "5"

      ############################
      # Audio outputs
      ############################

      # Local playback
      audio_output {
        type "pipewire"
        name "Local Output"
      }

      # Lossless FLAC stream
      audio_output {
        type "httpd"
        name "FLAC Stream"
        encoder "flac"
        port "8000"
        mixer_type "software"
      }

      # Mobile-friendly Opus stream
      audio_output {
        type "httpd"
        name "Opus Stream"
        encoder "opus"
        bitrate "192000"
        format "48000:16:2"
        port "8001"
        mixer_type "software"
      }

      ############################
      # ReplayGain
      ############################
      replaygain "album"
      replaygain_preamp "0"
      volume_normalization "no"

      ############################
      # Metadata
      ############################
      metadata_to_use "artist,album,title,track,name,date,genre"
    '';
  };

  home.packages = with pkgs.unstable; [
    mpc
  ];
}

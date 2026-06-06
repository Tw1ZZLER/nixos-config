{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    mpd.enable = lib.mkEnableOption "Enable MPD music server";
  };

  config = lib.mkIf config.mpd.enable {
    services.mpd = {
      enable = true;
      package = pkgs.mpd;
      musicDirectory = "/home/tw1zzler/media/music";
      dataDir = "${config.xdg.cacheHome}/mpd";
      playlistDirectory = "${config.xdg.configHome}/mpd/playlists";
      network = {
        listenAddress = "0.0.0.0";
        port = 6600;
        startWhenNeeded = false;
      };
      extraConfig = ''
        state_file   "${config.xdg.cacheHome}/mpd/state"
        sticker_file "${config.xdg.cacheHome}/mpd/sticker.sql"
        log_file     "${config.xdg.cacheHome}/mpd/log"
        auto_update "yes"
        auto_update_depth "5"
        audio_output {
          type "pipewire"
          name "Local Output"
        }
        audio_output {
          type "httpd"
          name "FLAC Stream"
          encoder "flac"
          port "8000"
          mixer_type "software"
        }
        audio_output {
          type "httpd"
          name "Opus Stream"
          encoder "opus"
          bitrate "192000"
          format "48000:16:2"
          port "8001"
          mixer_type "software"
        }
        replaygain "album"
        replaygain_preamp "0"
        volume_normalization "no"
        metadata_to_use "artist,album,title,track,name,date,genre"
      '';
    };
  };
}

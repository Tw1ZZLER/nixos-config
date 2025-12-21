{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    rmpc.enable = lib.mkEnableOption "Enable rmpc, a remote client for MPD";
  };

  config = lib.mkIf config.rmpc.enable {
    programs.rmpc = {
      enable = true;
      package = pkgs.unstable.rmpc;
      config = ''
        (
            address: "100.80.238.41:6600",
            password: None,
            theme: None,
            cache_dir: None,
            on_song_change: None,
            volume_step: 5,
            max_fps: 30,
            scrolloff: 0,
            wrap_navigation: false,
            enable_mouse: true,
            enable_config_hot_reload: true,
            status_update_interval_ms: 1000,
            select_current_song_on_change: false,
            browser_song_sort: [Disc, Track, Artist, Title],
        )
      '';
    };
  };
}

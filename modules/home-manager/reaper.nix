{ pkgs }:
{
  home.packages = with pkgs.unstable; [
    # Music stuff
    # An extra line later is needed to actually link ReaPack into ~/.config/REAPER/UserPlugins/
    reaper # WARN: Proprietary
    reaper-reapack-extension
    carla # Audio plugin host
  ];

  # Link ReaPack to Reaper User Plugins
  home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
    source = pkgs.unstable.reaper-reapack-extension + "/UserPlugins/reaper_reapack-x86_64.so";
  };

  # Link Carla Plugins to Reaper VST and LV2 Plugins
  home.file.".vst/carla.vst" = {
    source = pkgs.unstable.carla + "/lib/vst/carla.vst";
  };
  home.file.".lv2/carla.lv2" = {
    source = pkgs.unstable.carla + "/lib/lv2/carla.lv2";
  };
}

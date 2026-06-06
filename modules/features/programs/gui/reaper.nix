# Reaper DAW and other music stuff related to it
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.reaper = {pkgs, ...}: {
    home.packages = with pkgs; [
      # An extra line later is needed to actually link ReaPack into ~/.config/REAPER/UserPlugins/
      reaper # WARN: Proprietary
      reaper-reapack-extension
      carla # Audio plugin host

      yabridge # Run Windows VST plugins on Linux
      yabridgectl
    ];

    # Link ReaPack to Reaper User Plugins
    home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
      source = pkgs.reaper-reapack-extension + "/UserPlugins/reaper_reapack-x86_64.so";
    };

    # Link Carla Plugins to Reaper VST and LV2 Plugins
    home.file.".vst/carla.vst" = {
      source = pkgs.carla + "/lib/vst/carla.vst";
    };
    home.file.".lv2/carla.lv2" = {
      source = pkgs.carla + "/lib/lv2/carla.lv2";
    };
  };
}

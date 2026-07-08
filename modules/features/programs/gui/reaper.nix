# Reaper DAW and other music stuff related to it
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.reaper = {pkgs, ...}: let
    # Create a wrapped version of REAPER that includes PipeWire's JACK library
    wrappedReaper = pkgs.symlinkJoin {
      name = "reaper-wrapped";
      paths = [pkgs.reaper];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/reaper \
          --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
      '';
    };
  in {
    home.packages = with pkgs; [
      wrappedReaper # Use our custom wrapped REAPER instead of the stock one
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

    # Link Neural Amp Modeler LV2 to Reaper LV2 Plugins
    home.file.".lv2/neural_amp_modeler.lv2" = {
      source = pkgs.neural-amp-modeler-lv2 + "/lib/lv2/neural_amp_modeler.lv2";
    };
  };
}

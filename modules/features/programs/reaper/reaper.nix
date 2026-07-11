# Reaper DAW and other music stuff related to it
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.reaper = {
    config,
    pkgs,
    ...
  }: let
    # Create a wrapped version of REAPER that includes PipeWire's JACK library
    # wrappedReaper = pkgs.symlinkJoin {
    #   name = "reaper-wrapped";
    #   paths = [pkgs.reaper];
    #   nativeBuildInputs = [pkgs.makeWrapper];
    #   postBuild = ''
    #     wrapProgram $out/bin/reaper \
    #       --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
    #   '';
    # };
  in {
    imports = [inputs.reaper-flake.homeModules.reaper];

    programs.reaper = {
      enable = true;
      # configPath = "${config.xdg.configHome}/REAPER";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      swell.colortheme = {
        enable = true;

        # Use "stylix" here when Stylix is imported.
        preset = "reapertips";

        settings = {
          default_font_face = "Liberation Sans";
          default_font_size = 13;
          menubar_height = 17;
          scrollbar_width = 14;
          focus_hilight = "#d1a660";
        };
      };
    };

    home.packages = with pkgs; [
      # wrappedReaper # Use our custom wrapped REAPER instead of the stock one
      # reaper-reapack-extension
      carla # Audio plugin host

      yabridge # Run Windows VST plugins on Linux
      yabridgectl
    ];

    # Link ReaPack to Reaper User Plugins
    # home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so" = {
    #   source = pkgs.reaper-reapack-extension + "/UserPlugins/reaper_reapack-x86_64.so";
    # };

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

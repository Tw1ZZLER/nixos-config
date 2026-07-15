# Reaper DAW and other music stuff related to it
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.reaper = {
    config,
    pkgs,
    reaperActions,
    reaperMouse,
    reaperWindows,
    reaperAppearance,
    ...
  }: let
    reaper-config = "reaper-flake";
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
      configPath = "${config.xdg.configHome}/${reaper-config}";

      extensions = {
        reapack.enable = true;
        sws.enable = true;
      };

      swell.colortheme = {
        enable = true;

        # Use "stylix" here when Stylix is imported.
        preset = "reapertips";

        # settings = {
        #   default_font_face = "Liberation Sans";
        #   default_font_size = 13;
        #   menubar_height = 17;
        #   scrollbar_width = 14;
        #   focus_hilight = "#d1a660";
        # };
      };

      actions = {
        keyBindings = with reaperActions;
          bindings [
            (shortcut {
              shortcut = "J";
              command = 40285;
              actionName = "Track: Go to next track";
            })
            (shortcut {
              shortcut = "K";
              command = 40286;
              actionName = "Track: Go to previous track";
            })

            {
              modifierFlags = 255;
              keyCode = 2040;
              command = 989;
              section = sections.main;
              comment = "Main : Mousewheel : OVERRIDE DEFAULT : View: Scroll vertically (MIDI CC relative/mousewheel)";
            }
          ];
      };

      preferences = {
        windows = {
          tcpHelpBar = {
            informationDisplay = reaperWindows.tcpHelpBar.informationDisplay.cpuRamUseTimeSinceLastSave;
            showMouseEditingHelp = true;
          };
          mixer.master.showInDockerOrWindow = true;
        };

        project = {
          backups = {
            whenSaving = {
              preservePreviousVersionAsRppBak = false;
              preserveAllPreviousVersionsInOneRppBak = false;
              preservePreviouslySavedVersionOfProjectAsRppBak = {
                enable = true;
                saveTimestampedBackupsToProjectBackupsSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };
            };

            autoSave = {
              autoSaveToTimestampedFileInProjectDirectory = {
                enable = true;
                saveBackupsToProjectAutoSavesSubdirectory = true;

                limitAutoSavedBackupsToMostRecent = {
                  enable = true;
                  count = 50;
                  unit = "copies";
                };
              };

              autoSaveUnsavedProjectsToTemporaryFile = true;
              autoSaveInterval = {
                minutes = 10;
                mode = "whenNotRecording";
              };
            };
          };
        };

        appearance = {
          trackControlPanels = {
            setTrackLabelBackgroundToCustomTrackColors = true;
            tintTrackPanelBackgrounds = false;
            alignTcpControlsWhenTrackIconsOrFixedItemLanesAreUsed = true;

            showFxInserts = true;
            showSends = true;
            groupSendsWithFxInserts = false;
            groupFxParametersWithInserts = true;

            trackGroupingIndicators = reaperAppearance.trackControlPanels.trackGroupingIndicators.ribbons;
            folderCollapseButtonCyclesTrackHeights = reaperAppearance.trackControlPanels.folderCollapseButtonCyclesTrackHeights.normalHidden;
            fixedLaneCollapseButtonChangesDisplay = reaperAppearance.trackControlPanels.fixedLaneCollapseButtonChangesDisplay.oneManyLanes;
          };

          zoomScrollOffset = {
            verticalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.vertical.lastSelectedTrack;
            maximumVerticalZoom = 0.90;
            envelopeLaneVerticalZoom = 0.5;
            horizontalZoomCenter = reaperAppearance.zoomScrollOffset.zoomCenter.horizontal.mouseCursor;

            limitHorizontalZoomScrollToProjectStart = true;
            verticalScrollStep = {
              unit = reaperAppearance.zoomScrollOffset.verticalScrollStep.units.trackHeight;
              trackHeight = 0.5;
              arrangeViewHeight = 0.1;
            };
            disableMousewheelVerticalZoomForTracksThatArePinnedInArrangeView = true;
            overlappingMediaItems = {
              offset = 100;
              drawAsOpaque = true;
              arrangeInCreationOrder = false;
            };
          };
        };

        editingBehavior = {
          mouseModifiers = {
            importedContexts = with reaperMouse; [
              contexts.arrange.middleDrag
              contexts.midiPianoRoll.leftClick
            ];

            contexts = with reaperMouse;
              merge [
                (set contexts.arrange.middleDrag modifiers.none (mouse 9))
                (set contexts.midiPianoRoll.leftClick modifiers.none (mouse 4))
              ];
          };
        };

        plugIns.reascript.python.enable = true;
      };

      layout = {
        docks = {
          bottom = {
            id = 3;
            position = "bottom";
            selectedPanel = "mixer";
          };

          left = {
            id = 2;
            position = "left";
            size = 395;
            selectedPanel = "explorer";
          };

          right = {
            id = 1;
            position = "right";
            selectedPanel = "mastermixer";
          };
        };

        transport = {
          visible = true;
          dockPosition = reaperWindows.transport.topOfMainWindow;
        };

        masterMixer = {
          visible = true;
          docked = true;
          dock = "right";
          tabOrder = 0.0;
        };

        mixer = {
          visible = false;
          docked = true;
          dock = "bottom";
          tabOrder = 0.0;
        };

        panels.explorer = {
          id = "explorer";
          section = "reaper_sexplorer";
          keyStyle = "window";
          visible = false;
          docked = true;
          dock = "left";
          tabOrder = 0.5;
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

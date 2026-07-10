# Automatic installation of Smooth 6 theme for REAPER
# yes this is AI slop
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.reaper-smooth6 = {
    pkgs,
    lib,
    ...
  }: let
    # Handle path configurations gracefully across Linux and macOS environments
    reaperDir =
      if pkgs.stdenv.isDarwin
      then "Library/Application Support/REAPER"
      else ".config/REAPER";

    smooth6Theme = pkgs.stdenv.mkDerivation {
      pname = "reaper-theme-smooth6-dark";
      version = "2.1";

      # Point to your downloaded archive containing the Smooth 6 theme variants
      src = ./Smooth_6_v2.1.zip;

      nativeBuildInputs = [pkgs.unzip];

      unpackCmd = "unzip $curSrc -d dest";

      installPhase = ''
        mkdir -p $out/ColorThemes
        mkdir -p $out/Scripts/Cockos

        # 1. Extract all .ReaperThemeZip files found in the archive (captures Light, Dark, etc.)
        find dest -type f -name "*.ReaperThemeZip" -exec cp {} $out/ColorThemes/ \;

        # 2. Extract the relative theme adjuster script framework
        ADJUSTER_SRC=$(dirname "$(find dest -type f -name "*theme_adjuster*.lua" | head -n 1)")
        if [ -d "$ADJUSTER_SRC" ]; then
          cp -r "$ADJUSTER_SRC"/* $out/Scripts/Cockos/
        fi
      '';
    };
  in {
    # Merge all found theme files cleanly into REAPER's ColorThemes directory
    # 'recursive = true' ensures Home Manager safely updates this folder without wiping out other themes
    home.file."${reaperDir}/ColorThemes" = {
      source = "${smooth6Theme}/ColorThemes";
      recursive = true;
    };

    # Merge the layout adjuster scripts safely into the default Cockos environment
    home.file."${reaperDir}/Scripts/Cockos" = {
      source = "${smooth6Theme}/Scripts/Cockos";
      recursive = true;
    };

    # Automatic ini injector targeting the Dark configuration specifically
    home.activation.setReaperTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
      REAPER_INI="$HOME/${reaperDir}/reaper.ini"
      TARGET_THEME="Smooth_6_Dark.ReaperTheme"

      if [ -f "$REAPER_INI" ]; then
        if grep -q "^colortheme=" "$REAPER_INI"; then
          # Swap out whatever theme was previously configured
          sed -i "s|^colortheme=.*|colortheme=$TARGET_THEME|" "$REAPER_INI"
        else
          # Inject the key directly under the global REAPER layout block
          sed -i "/^\[REAPER\]/a colortheme=$TARGET_THEME" "$REAPER_INI"
        fi
      else
        # Fallback initialization if running on a fresh user profile
        mkdir -p "$(dirname "$REAPER_INI")"
        echo -e "[REAPER]\ncolortheme=$TARGET_THEME" > "$REAPER_INI"
      fi
    '';
  };
}

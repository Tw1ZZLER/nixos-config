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
    # 1. Handle REAPER configuration pathways across environments
    reaperDir =
      if pkgs.stdenv.isDarwin
      then "Library/Application Support/REAPER"
      else ".config/REAPER";

    # 2. Track OS-specific fonts directory
    fontDir =
      if pkgs.stdenv.isDarwin
      then "Library/Fonts"
      else ".local/share/fonts/truetype/smooth6";

    smooth6Theme = pkgs.stdenv.mkDerivation {
      pname = "reaper-theme-smooth6-dark";
      version = "2.1";

      src = ./Smooth_6_v2.1.zip;

      nativeBuildInputs = [pkgs.unzip];

      unpackCmd = "unzip $curSrc -d dest";

      installPhase = ''
        mkdir -p $out/ColorThemes
        mkdir -p $out/Scripts/Cockos
        mkdir -p $out/Fonts

        # Match both the packed bundle (.ReaperThemeZip) and loose variation files (.ReaperTheme)
        find dest -type f \( -name "*.ReaperThemeZip" -o -name "*.ReaperTheme" \) -exec cp {} $out/ColorThemes/ \;

        # Extract theme adjuster scripts (.lua)
        ADJUSTER_SRC=$(dirname "$(find dest -type f -name "*theme_adjuster*.lua" | head -n 1)")
        if [ -d "$ADJUSTER_SRC" ]; then
          cp -r "$ADJUSTER_SRC"/* $out/Scripts/Cockos/
        fi

        # Extract all bundled TrueType and OpenType fonts safely
        find dest -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} $out/Fonts/ \;
      '';
    };
  in {
    # Merge all theme layouts into REAPER's ColorThemes directory
    home.file."${reaperDir}/ColorThemes" = {
      source = "${smooth6Theme}/ColorThemes";
      recursive = true;
    };

    # Merge scripts into REAPER
    home.file."${reaperDir}/Scripts/Cockos" = {
      source = "${smooth6Theme}/Scripts/Cockos";
      recursive = true;
    };

    # Symlink custom fonts into your OS font environment
    home.file."${fontDir}" = {
      source = "${smooth6Theme}/Fonts";
      recursive = true;
    };

    # Automatic config editor targeting the Dark configuration precisely
    home.activation.setReaperTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
      REAPER_INI="$HOME/${reaperDir}/reaper.ini"
      TARGET_THEME="Smooth_6_Dark.ReaperTheme"

      if [ -f "$REAPER_INI" ]; then
        if grep -q "^colortheme=" "$REAPER_INI"; then
          sed -i "s|^colortheme=.*|colortheme=$TARGET_THEME|" "$REAPER_INI"
        else
          sed -i "/^\[REAPER\]/a colortheme=$TARGET_THEME" "$REAPER_INI"
        fi
      else
        mkdir -p "$(dirname "$REAPER_INI")"
        echo -e "[REAPER]\ncolortheme=$TARGET_THEME" > "$REAPER_INI"
      fi
    '';
  };
}

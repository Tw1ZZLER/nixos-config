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
    reaperDir =
      if pkgs.stdenv.isDarwin
      then "Library/Application Support/REAPER"
      else ".config/REAPER";

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

        # 1. Search relative to '.' (since Nix already CD'd into dest)
        # and explicitly ignore macOS metadata resource forks
        find . -type f \( -name "*.ReaperThemeZip" -o -name "*.ReaperTheme" \) ! -path "*/__MACOSX/*" ! -name "._*" -exec cp {} $out/ColorThemes/ \;

        # 2. Safely isolate and extract layout adjuster scripts
        ADJUSTER_FILE=$(find . -type f -name "*theme_adjuster*.lua" ! -path "*/__MACOSX/*" ! -name "._*" | head -n 1)
        if [ -n "$ADJUSTER_FILE" ]; then
          ADJUSTER_SRC=$(dirname "$ADJUSTER_FILE")
          cp -r "$ADJUSTER_SRC"/* $out/Scripts/Cockos/
        fi

        # 3. Extract typography assets
        find . -type f \( -name "*.ttf" -o -name "*.otf" \) ! -path "*/__MACOSX/*" ! -name "._*" -exec cp {} $out/Fonts/ \;
      '';
    };
  in {
    home.file."${reaperDir}/ColorThemes" = {
      source = "${smooth6Theme}/ColorThemes";
      recursive = true;
    };

    home.file."${reaperDir}/Scripts/Cockos" = {
      source = "${smooth6Theme}/Scripts/Cockos";
      recursive = true;
    };

    home.file."${fontDir}" = {
      source = "${smooth6Theme}/Fonts";
      recursive = true;
    };

    # Adjusted to target "Smooth_6_Windows_Dark.ReaperTheme" as seen in your logs.
    # (Note: If you are on Linux/macOS, REAPER can still read this layout completely fine)
    home.activation.setReaperTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
      REAPER_INI="$HOME/${reaperDir}/reaper.ini"
      TARGET_THEME="Smooth_6_Windows_Dark.ReaperTheme"

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

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    research.enable = pkgs.lib.mkEnableOption "Enable research and academic tools";
  };
  config = pkgs.lib.mkIf config.research.enable {
    home.packages = with pkgs.unstable; [
      zotero
      # jabref
      # texstudio
      # texlive-full # WARN: Very large
      # mathematica # WARN: Proprietary
      # matlab # WARN: Proprietary
      # octave
      # rstudio
      # spyder
      # anaconda3
      # jupyterlab
      # mendeley # WARN: Proprietary
    ];
  };
}

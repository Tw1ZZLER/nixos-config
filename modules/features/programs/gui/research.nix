# Enable research and academic tools
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.research = {pkgs, ...}: {
    home.packages = with pkgs; [
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

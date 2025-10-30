# Stuff I need for college
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    wpsoffice # WARN: Proprietary
    omnissa-horizon-client # WARN: Proprietary

    # Waveforms
    # inputs.waveforms.packages.${system}.waveforms
  ];
}

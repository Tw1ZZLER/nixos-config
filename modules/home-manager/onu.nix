# Stuff I need for college
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    onu.enable = lib.mkEnableOption "Enable tools and applications needed for college";
  };

  config = lib.mkIf config.onu.enable {
    home.packages = with pkgs.unstable; [
      wpsoffice # WARN: Proprietary
      omnissa-horizon-client # WARN: Proprietary

      # Waveforms
      # inputs.waveforms.packages.${system}.waveforms
    ];
  };
}

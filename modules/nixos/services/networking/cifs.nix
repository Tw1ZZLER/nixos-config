{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cifs.enable = lib.mkEnableOption "Enable CIFS utilities for mounting SMB/CIFS shares";
  };
  config = lib.mkIf config.cifs.enable {
    # For mount.cifs, required unless domain name resolution is not needed.
    environment.systemPackages = [ pkgs.cifs-utils ];
  };
}

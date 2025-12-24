{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fd.enable = lib.mkEnableOption "Enable fd, a simple, fast and user-friendly alternative to 'find'";
  };

  config = lib.mkIf config.fd.enable {
    programs.fd = {
      enable = true;
      package = pkgs.unstable.fd;
    };
  };
}

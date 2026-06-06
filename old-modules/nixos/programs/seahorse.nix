{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    seahorse.enable = lib.mkEnableOption "Enable Seahorse for managing encryption keys";
  };
  config = lib.mkIf config.seahorse.enable {
    programs.seahorse.enable = true;
  };
}

# The best personal knowledge management system (its proprietary unfortunately)
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    obsidian.enable = lib.mkEnableOption "Enable Obsidian";
  };

  config = lib.mkIf config.obsidian.enable {
    programs.obsidian = {
      enable = true;
      package = pkgs.unstable.obsidian;
    };
  };
}

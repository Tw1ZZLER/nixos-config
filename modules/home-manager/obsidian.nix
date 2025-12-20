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
    home.packages = with pkgs.unstable; [
      obsidian
    ];
  };
}

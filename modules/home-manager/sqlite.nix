{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sqlite.enable = lib.mkEnableOption "Enable SQLite command-line tool";
  };
  config = lib.mkIf config.sqlite.enable {
    home.packages = with pkgs.unstable; [
      sqlite
    ];
  };

}

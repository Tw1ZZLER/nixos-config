{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    ncmpcpp.enable = lib.mkEnableOption "Enable ncmpcpp music client";
  };

  config = lib.mkIf config.ncmpcpp.enable {
    programs.ncmpcpp = {
      enable = true;
      package = pkgs.unstable.ncmpcpp;
      settings = {
        mpd_host = "100.80.238.41";
        mpd_port = "6600";
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        progressbar_look = "━━";
      };
    };
    home.packages = with pkgs.unstable; [
      mpc
    ];
  };
}

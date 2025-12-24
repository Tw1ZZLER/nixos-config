{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fastfetch.enable = lib.mkEnableOption "Enable fastfetch, a fast and highly customizable system information tool";
  };

  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      package = pkgs.unstable.fastfetch;
      settings = ../../../../dotfiles/fastfetch/config.jsonc;
    };
  };
}

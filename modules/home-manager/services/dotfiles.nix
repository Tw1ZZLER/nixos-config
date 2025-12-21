{ lib, config, ... }:

{
  options = {
    dotfiles.enable = lib.mkEnableOption "Enable dotfiles linking";
  };

  config = lib.mkIf config.dotfiles.enable {
    xdg.configFile.fastfetch = {
      recursive = true;
      source = ../../dotfiles/fastfetch;
    };
    xdg.configFile.yazi = {
      recursive = true;
      source = ../../dotfiles/yazi;
    };
  };
}

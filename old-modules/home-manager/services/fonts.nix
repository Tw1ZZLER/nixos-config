{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    fonts.enable = lib.mkEnableOption "Enable custom fonts";
  };

  config = lib.mkIf config.fonts.enable {
    fonts.fontconfig = {
      enable = true;
    };

    home.packages = with pkgs.unstable; [
      nerd-fonts.victor-mono
      corefonts
      monocraft
    ];
  };
}

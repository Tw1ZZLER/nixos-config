{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    eza.enable = lib.mkEnableOption "Enable eza, an enhanced ls command";
  };

  config = lib.mkIf config.eza.enable {
    programs.eza = {
      enable = true;
      package = pkgs.unstable.eza;
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ripgrep.enable = lib.mkEnableOption "Enable ripgrep, an enhanced grep command";
  };

  config = lib.mkIf config.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      package = pkgs.unstable.ripgrep;
    };
  };
}

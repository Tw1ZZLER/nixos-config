{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "Enable fzf, a command-line fuzzy finder";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      package = pkgs.unstable.fzf;
    };
  };
}

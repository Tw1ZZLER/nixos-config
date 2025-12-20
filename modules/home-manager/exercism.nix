{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    exercism.enable = lib.mkEnableOption "Enable Exercism CLI";
  };

  config = lib.mkIf config.exercism.enable {
    home.packages = with pkgs.unstable; [
      exercism
    ];
  };
}

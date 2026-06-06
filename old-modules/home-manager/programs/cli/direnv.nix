{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    direnv.enable = lib.mkEnableOption "Enable direnv, an environment switcher for the shell";
  };

  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      package = pkgs.unstable.direnv;
      nix-direnv.enable = true;
      nix-direnv.package = pkgs.unstable.nix-direnv;
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    nix-index.enable = lib.mkEnableOption "Enable nix-index tool for home-manager";
  };

  config = lib.mkIf config.nix-index.enable {
    programs.nix-index.enable = true;
  };
}

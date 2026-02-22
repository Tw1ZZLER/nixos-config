{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    nixgl.enable = lib.mkEnableOption "Enable NixGL for OpenGL support on non-NixOS systems.";
  };
  config = lib.mkIf config.nixgl.enable {
    # NixGL settings
    targets.genericLinux.nixGL = {
      packages = inputs.nixgl.packages;
      defaultWrapper = "mesa";
      installScripts = [ "mesa" ];
    };
  };
}

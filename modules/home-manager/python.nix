# Python stuff
# This is for GENERAL PURPOSE PYthon usage, for project-specific stuff use poetry.nix or flakes.nix
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    python.enable = lib.mkEnableOption "Enable general purpose Python packages";
  };
  config = lib.mkIf config.python.enable {
    home.packages = with pkgs.unstable; [
      python313
      python313Packages.pip
      python313Packages.virtualenv
      python313Packages.numpy
      python313Packages.pandas
      python313Packages.requests
      python313Packages.flask
      python313Packages.django
      python313Packages.jupyterlab
    ];
  };
}

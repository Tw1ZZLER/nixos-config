# Python stuff
# This is for GENERAL PURPOSE PYthon usage, for project-specific stuff use poetry.nix or flakes.nix
{ pkgs, ... }:
{
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
}

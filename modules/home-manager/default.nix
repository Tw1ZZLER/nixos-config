# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{
  lib,
  config,
  ...
}@args:
{
  # List your module files here
  # my-module = import ./my-module.nix;
  # DEFAULTS For all systems!
  imports = [
    ../common
    ./programs
    ./services
  ];

  # Disable nixpkgs config on NixOS, as it is already handled with home-manager.useGlobalPkgs, and is already set in the NixOS modules
  nixpkgs-wrapper.enable = lib.mkIf (args ? osConfig) false;

  # I don't see this stuff ever changing
  home = {
    username = "tw1zzler";
    homeDirectory = "/home/tw1zzler";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

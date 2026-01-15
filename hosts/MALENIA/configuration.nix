# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    # ./hardware-configuration.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules

    # Or modules from other flakes
    inputs.home-manager.nixosModules.home-manager
  ];

  # Hardware specific configuration, see section below for a more complete
  # list of modules
  imports = with inputs.nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
  ];

  # Server configuration module for running server
  server-networking.enable = true;

  # Optional: Binary cache for the flake
  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberryPi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "MALENIA";
  networking.networkmanager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}

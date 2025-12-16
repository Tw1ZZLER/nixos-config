# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # You can also split up your configuration and import pieces of it here:
    # DEFAULTS for all systems
    ../../modules/nixos

    # Not defaults (changes per system)
    ../../modules/nixos/intel-graphics.nix
    ../../modules/nixos/cosmic.nix
    ../../modules/nixos/plymouth.nix

    # ../../modules/nixos/stylix.nix
    ../../modules/nixos/catppuccin.nix
  ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System76 hardware
  hardware.system76.enableAll = true;

  # Networking
  networking.hostName = "PRIMUS";
  networking.networkmanager.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # C/C++ compiler
    gcc
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}

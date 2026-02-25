# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules

    # Or modules from other flakes
    inputs.home-manager.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
    inputs.stylix.nixosModules.stylix
  ];

  # Boot splash screen
  plymouth.enable = true;

  # Display manager
  # cosmic-greeter.enable = true;
  ly.enable = true;

  # Desktop environment
  # cosmic.enable = true;
  hyprland.enable = true;
  niri.enable = true;
  flatpak.enable = true;

  # Intel hardware
  intel-graphics.enable = true;

  # ONU Printers and Drives
  onu-printers.enable = true;
  onu-drives.enable = true;

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

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # C/C++ compiler
    gcc
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}

# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  pkgs,
  lib,
  ...
}:

with lib;
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
    # ../../modules/nixos

    # Not defaults (changes per system)
  ];

  # Do not remove these subsystem settings
  garuda.subsystem.enable = true;
  garuda.managed.config = ./garuda-managed.json;

  garuda.dr460nized.enable = true;

  # This should never be changed unless you know exactly what you are doing.
  # This has no impact on any package updates or OS version.
  system.stateVersion = "24.11";
}

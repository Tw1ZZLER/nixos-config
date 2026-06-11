{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.PRIMUS = inputs.nixpkgs.lib.nixosSystem {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.nixosModules.PRIMUS # this is defined right -----> |
    ]; #                                                      ↓
  }; #      |  <-----------------------------------------------
  #         ↓  here (as well as hardware-configuration.nix)
  flake.nixosModules.PRIMUS = {pkgs, ...}: {
    imports = [
      # Move these to their own respective NixOS modules later
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix

      # Boot splash screen
      self.nixosModules.plymouth

      # Display manager
      self.nixosModules.ly

      # Desktop environment
      self.nixosModules.hyprland
      self.nixosModules.niri

      # Nixpkgs wrapper
      self.nixosModules.nixpkgs-wrapper

      # Intel hardware
      self.nixosModules.intel-graphics

      # Printers and drives
      self.nixosModules.onu-printers
      self.nixosModules.onu-drives
      self.nixosModules.argonne-printers

      # CLI Programs
      self.nixosModules.bash
      self.nixosModules.nix-ld
      self.nixosModules.sops
      self.nixosModules.trashy

      # GUI Programs
      self.nixosModules.gpu-screen-recorder
      self.nixosModules.seahorse
      self.nixosModules.steam
      self.nixosModules.system76-keyboard-configurator
      self.nixosModules.waveforms
      self.nixosModules.weylus
      self.nixosModules.wine

      # Services
      self.nixosModules.ssh
      self.nixosModules.tailscale
      self.nixosModules.flatpak
    ];

    # Home-manager configuration
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.tw1zzler.imports = [
        self.homeModules."tw1zzler@PRIMUS"
      ];
    };

    boot = {
      # Boot loader
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # Kernel
      kernelPackages = pkgs.linuxPackages_latest;
    };

    # System76 hardware
    hardware.system76.enableAll = true;

    # Networking
    networking = {
      hostName = "PRIMUS";
      networkmanager.enable = true;
    };

    hardware.bluetooth.enable = true;
    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;

      # Touchpad support
      libinput.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # C/C++ compiler
      gcc
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "25.05";
  };
}

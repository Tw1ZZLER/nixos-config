{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.PRIMUS = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.PRIMUS # this is defined right -----> |
    ]; #                                                      ↓
  }; #      |  <-----------------------------------------------
  #         ↓  here (as well as hardware-configuration.nix)
  flake.nixosModules.PRIMUS = {pkgs, ...}: {
    imports = with self.nixosModules; [
      # Boot splash screen
      plymouth

      # Display manager
      greetd

      # Desktop environment
      hyprland
      niri

      # Nixpkgs
      xilinx

      # Intel hardware
      intel-graphics

      # Printers and drives
      onu-printers
      onu-drives
      argonne-printers

      # CLI Programs
      bash
      fish
      nix-ld
      sops
      trashy

      # GUI Programs
      gpu-screen-recorder
      seahorse
      steam
      system76-keyboard-configurator
      waveforms
      weylus
      wine

      # Services
      ssh
      tailscale
      flatpak
      stylix-wrapper

      # System
      user-tw1zzler
      nix-wrapper
      pipewire
      printing
      timezone

      # Virtualisation
      docker
      virt-manager
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

    nixpkgs.config.allowUnfree = true;

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

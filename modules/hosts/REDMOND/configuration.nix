{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.REDMOND = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.REDMOND # this is defined right -----> |
    ]; #                                                      ↓
  }; #      |  <-----------------------------------------------
  #         ↓  here (as well as hardware-configuration.nix)
  flake.nixosModules.REDMOND = {pkgs, ...}: {
    imports = with self.nixosModules; [
      # Kernel settings
      sysrq

      # Boot splash screen
      plymouth

      # Display manager
      greetd

      # Desktop environment
      niri

      # Nixpkgs
      nixpkgs-config

      # CLI Programs
      bash
      fish
      sops
      trashy

      # GUI Programs
      wine

      # Services
      ssh
      tailscale
      # flatpak
      stylix-wrapper

      # System
      user-tw1zzler
      user-root
      nix-wrapper
      pipewire
      printing # figure out why foomatic-db-ppds takes so damn long then re-enable
      locale

      # Virtualisation
      docker
      build-system-aarch64
    ];

    # Timezone
    time.timeZone = "America/Detroit";

    # Home-manager configuration
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.tw1zzler.imports = [
        self.homeModules."tw1zzler@REDMOND"
      ];
    };

    boot = {
      # Boot loader
      loader = {
        grub = {
          enable = true;
          device = "nodev"; # "nodev" is used for UEFI
          efiSupport = true;
        };
        efi.canTouchEfiVariables = true;
      };

      # Kernel
      kernelPackages = pkgs.linuxPackages_latest;
    };

    # Networking
    networking = {
      hostName = "REDMOND";
      networkmanager.enable = true;
    };

    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [
      # C/C++ compiler
      gcc
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
  };
}

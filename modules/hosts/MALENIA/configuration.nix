{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.MALENIA = inputs.nixos-raspberrypi.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.MALENIA
    ];
  };

  flake.nixosModules.MALENIA = {lib, ...}: {
    imports = [
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k

      # Kernel settings
      self.nixosModules.sysrq

      self.nixosModules.nixpkgs-config

      self.nixosModules.malenia-disko
      self.nixosModules.server-networking
      self.nixosModules.ssh
      self.nixosModules.tailscale
      self.nixosModules.sops
      self.nixosModules.user-tw1zzler
      self.nixosModules.nix-wrapper

      # Homelab stuff
      self.nixosModules.nextcloud
      self.nixosModules.pi-hole

      self.nixosModules.malenia-wifi
    ];

    # Tailscale settings for subnetting etc
    services.tailscale.useRoutingFeatures = "server";
    networking = {
      hostName = "MALENIA";
      firewall.checkReversePath = "loose";
      nftables.enable = true;
    };

    boot.loader.raspberry-pi = {
      bootloader = "kernel";
      firmwarePath = "/boot";
    };

    sops = {
      age.keyFile = lib.mkForce "/etc/sops/age/key.txt";
      secrets = {
        malenia-wifi-superbad-psk = {};
        malenia-pihole-admin-password = {};
      };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "25.11";
  };
}

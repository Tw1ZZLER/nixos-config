{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.MALENIA = inputs.nixos-raspberrypi.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.MALENIA
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    ];
  };

  flake.nixosModules.MALENIA = {lib, ...}: {
    imports = with self.nixosModules; [
      # Kernel settings
      sysrq

      nixpkgs-config

      malenia-disko
      server-networking
      ssh
      tailscale
      sops
      user-tw1zzler
      nix-wrapper

      # Homelab stuff
      nextcloud
      pi-hole

      malenia-wifi
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

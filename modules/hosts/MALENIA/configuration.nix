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

      self.nixosModules.server-networking
      self.nixosModules.ssh
      self.nixosModules.sops
      self.nixosModules.user-tw1zzler
      self.nixosModules.nix-wrapper

      self.nixosModules.malenia-wifi
    ];

    networking.hostName = "MALENIA";

    boot.loader.raspberry-pi.bootloader = "kernel";

    sops = {
      age.keyFile = lib.mkForce "/etc/sops/age/key.txt";
      secrets.malenia-wifi-superbad-psk = {};
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "25.11";
  };
}

{ self, inputs, ... }:
{

  flake.nixosConfigurations.PRIMUS = inputs.nixpkgs.lib.nixosSystem {
    modules = [ ];
  };

}

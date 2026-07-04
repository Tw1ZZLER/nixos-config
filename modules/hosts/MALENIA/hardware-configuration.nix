{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.MALENIA = {lib, ...}: {
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}

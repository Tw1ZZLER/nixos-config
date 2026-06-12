# This module for Nixpkgs is useful in both NixOS and home-manager, so it goes here (I am using it in both)
{
  self,
  withSystem,
  inputs,
  ...
}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      # overlays = [ inputs.foo.overlays.default ];
      config = {
        allowUnfree = true;
      };
    };
  };

  # flake.nixosModules.nixpkgs-wrapper = {config, ...}: {
  #   imports = [
  #     # Ensures no other modules overwrite nixpkgs
  #     inputs.nixpkgs.nixosModules.readOnlyPkgs
  #   ];
  #   # Use the configured pkgs from perSystem
  #   nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
  #     {pkgs, ...}:
  #     # perSystem module arguments
  #       pkgs
  #   );
  # };
}

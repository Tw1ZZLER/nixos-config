# Run dynamically linked binaries
# Enable nix-ld for dynamically linked binaries
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-ld = {pkgs, ...}: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # add any missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
        icu
        statix
      ];
    };
  };
}

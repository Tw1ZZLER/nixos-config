# Run dynamically linked binaries
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nix-ld.enable = lib.mkEnableOption "Enable nix-ld for dynamically linked binaries";
  };
  config = lib.mkIf config.nix-ld.enable {
    programs = {
      nix-ld.enable = true;
      nix-ld.libraries = with pkgs; [
        # add any missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
        unstable.icu
        unstable.statix
      ];
    };
  };
}

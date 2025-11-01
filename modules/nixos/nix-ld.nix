{ pkgs, ... }:
{
  # Run dynamically linked binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
    unstable.icu
    unstable.statix
  ];
}

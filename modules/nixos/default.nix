{ lib, ... }:
# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{
  # List your module files here
  # my-module = import ./my-module.nix;
  # DEFAULTS For all systems!
  imports = [
    ../nixpkgs.nix
    ./cifs.nix
    ./docker.nix
    ./graphics.nix
    ./nix-index.nix
    ./nix-ld.nix
    ./nix.nix
    ./printing.nix
    ./samba.nix
    ./sound.nix
    ./ssh.nix
    ./steam.nix
    ./timezone.nix
    ./trash.nix
    ./user.nix
    ./virt-manager.nix
    ./weylus.nix
    ./wine.nix
  ];

  nix-index.enable = lib.mkDefault true;
}

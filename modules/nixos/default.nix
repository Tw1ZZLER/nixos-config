# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{
  # List your module files here
  # my-module = import ./my-module.nix;
  # DEFAULTS For all systems!
  imports = [
    ./docker.nix
    ./nix-ld.nix
    ./printing.nix
    ./sound.nix
    ./ssh.nix
    ./tailscale.nix
    ./timezone.nix
    ./user.nix
    ./virt-manager.nix
    ./wine.nix
  ];
}

{ lib, ... }:
{
  imports = [
    ./users
    ./nix-wrapper.nix
    ./printing.nix
    ./pipewire.nix
    ./timezone.nix
  ];

  nix-wrapper.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  pipewire.enable = lib.mkDefault true;
  timezone.enable = lib.mkDefault true;
}

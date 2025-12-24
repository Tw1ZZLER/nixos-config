{ lib, ... }:
{
  imports = [
    ./users
    ./printing.nix
    ./pipewire.nix
    ./timezone.nix
  ];

  printing.enable = lib.mkDefault true;
  pipewire.enable = lib.mkDefault true;
  timezone.enable = lib.mkDefault true;
}

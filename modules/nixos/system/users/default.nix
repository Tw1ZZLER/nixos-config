{ lib, ... }:
{
  imports = [
    ./tw1zzler.nix
  ];

  users.tw1zzler.enable = lib.mkDefault true;
}

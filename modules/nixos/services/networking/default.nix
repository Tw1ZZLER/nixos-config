{ lib, ... }:
{
  imports = [
    ./cifs.nix
    ./onu-drives.nix
    ./samba.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  cifs.enable = lib.mkDefault false;
  onu-drives.enable = lib.mkDefault false;
  samba.enable = lib.mkDefault false;
  ssh.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

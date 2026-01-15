{ lib, ... }:
{
  imports = [
    ./cifs.nix
    ./onu-drives.nix
    ./samba.nix
    ./server-networking.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  cifs.enable = lib.mkDefault false; # ONU-drives enables this
  onu-drives.enable = lib.mkDefault false;
  samba.enable = lib.mkDefault false; # ONU-drives enables this
  server-networking.enable = lib.mkDefault false;
  ssh.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}

# Tailscale VPN
# Lives in NixOS modules because home-manager on non-NixOS machines cannot change networking settings
{ }:
{
  services.tailscale.enable = true;
}

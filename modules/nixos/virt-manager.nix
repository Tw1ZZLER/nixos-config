# Virt-Manager with QEMU-KVM and libvirt
{ }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "tw1zzler" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

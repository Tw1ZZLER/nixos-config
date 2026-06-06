# Virt-Manager with QEMU-KVM and libvirt
{ lib, config, ... }:
{
  options = {
    virt-manager.enable = lib.mkEnableOption "Enable Virt-Manager with QEMU-KVM and libvirt";
  };
  config = lib.mkIf config.virt-manager.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "tw1zzler" ];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}

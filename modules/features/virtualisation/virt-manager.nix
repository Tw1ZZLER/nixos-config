# Virt-Manager with QEMU-KVM and libvirt
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.virt-manager = {...}: {
    programs.virt-manager.enable = true;

    # Im pretty sure these next two lines do identical things
    # but you can never be too sure
    users.users.tw1zzler.extraGroups = ["libvirtd"];
    users.groups.libvirtd.members = ["tw1zzler"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}

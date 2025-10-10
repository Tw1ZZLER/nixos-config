{ }:
{
  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    tw1zzler = {
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "password";
      isNormalUser = true;
      description = "Tw1ZZLER";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "dialout"
        "libvirtd"
        "kvm"
        "sudo"
        "adm"
        "lpadmin"
        "uinput"
      ];
    };
  };
}

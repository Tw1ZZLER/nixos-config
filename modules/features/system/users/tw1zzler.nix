# Enable user tw1zzler
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user-tw1zzler = {...}: {
    # Configure your system-wide user settings (groups, etc), add more users as needed.
    users.users.tw1zzler = {
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "password";
      isNormalUser = true;
      description = "Tw1ZZLER";
      openssh.authorizedKeys.keys = with inputs.nix-secrets.keys; [
        tw1zzler_PRIMUS
        tw1zzler_REDMOND
        tw1zzler_MALENIA
        PRIMUS
        REDMOND
        MALENIA
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "dialout"
        "kvm"
        "sudo"
        "adm"
        "lpadmin"
        "uinput"
      ];
    };
  };
}

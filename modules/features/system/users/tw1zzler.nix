# tw1zzler user config
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user-tw1zzler = {...}: {
    users = {
      mutableUsers = false;
      users.tw1zzler = {
        isNormalUser = true;
        hashedPassword = inputs.nix-secrets.passwords.tw1zzler;
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
  };
}

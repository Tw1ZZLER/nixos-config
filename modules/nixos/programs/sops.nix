{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options = {
    sops.enable = lib.mkEnableOption "Enable sops-nix for managing secrets";
  };

  config = lib.mkIf config.sops.enable {
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/tw1zzler/.config/sops/age/keys.txt";

      secrets = {
        example-key = { };
        "myservice/mysubdir/mysecret" = { };
      };
    };
  };
}

# Enable sops-nix for managing secrets
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sops = {...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/tw1zzler/.config/sops/age/keys.txt";

      secrets = {
        example-key = {};
      };
    };
  };
}

# Enable sops-nix for managing secrets from the private nix-secrets flake input.
# credit: https://codeberg.org/EmergentMind/nix-config/src/branch/dev/hosts/common/core/sops.nix
{
  self,
  inputs,
  ...
}: let
  sopsFolder = "${inputs.nix-secrets}/sops";
in {
  flake.nixosModules.sops = {lib, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {
      defaultSopsFile = "${sopsFolder}/shared.yaml";
      validateSopsFiles = false;
      defaultSopsFormat = "yaml";

      age = {
        # automatically import host SSH keys as age keys
        sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      };
    };
  };
}

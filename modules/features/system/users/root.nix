# root user
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user-root = {...}: {
    users = {
      mutableUsers = false;
      users.root = {
        hashedPassword = inputs.nix-secrets.passwords.root;
      };
    };
  };
}

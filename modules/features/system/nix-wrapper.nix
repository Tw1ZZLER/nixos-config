# Now this is Meta (Configuring Nix with Nix in Nix)
# Enable opinionated Nix configuration wrapper
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-wrapper = {...}: {
    nix = {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";

        # Binary Cache
        extra-substituters = ["https://noctalia.cachix.org"];
        extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
      };
      extraOptions = ''
        warn-dirty = false
      '';
      # add to extraOptions later when this secret is added
      # !include ${config.sops.secrets.nixAccessTokens.path}

      # Disable channels
      channel.enable = false;
    };
  };
}

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

        # Extra Binary Caches
        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://hercules-ci.cachix.org"
          "https://noctalia.cachix.org"
          "https://catppuccin.cachix.org"
          "https://nixos-raspberrypi.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hercules-ci.cachix.org-1:g99HiMR8Y9Z8mYicrKWW04daP0W5ZshhZ/pYgNfC+1U="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "catppuccin.cachix.org-1:noGdz9JST3clb8h9W9q6CZvGsDY6HG0cmM6b856w06M="
          "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
        trusted-users = [ "root" "tw1zzler" "@wheel" ];
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

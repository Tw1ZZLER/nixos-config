# Now this is Meta (Configuring Nix with Nix in Nix)
# Enable opinionated Nix configuration wrapper
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-wrapper = {
    lib,
    config,
    ...
  }: {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      extraOptions = ''
        warn-dirty = false
      '';
      # add to extraOptions later when this secret is added
      # !include ${config.sops.secrets.nixAccessTokens.path}

      # Disable channels
      channel.enable = false;

      # Make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
  };
}

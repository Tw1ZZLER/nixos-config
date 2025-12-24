# Now this is Meta (Configuring Nix with Nix in Nix)
{
  lib,
  inputs,
  config,
  ...
}:
{
  options = {
    nix-wrapper.enable = lib.mkEnableOption "Enable opinionated Nix configuration wrapper.";
  };
  config = lib.mkIf config.nix-wrapper.enable {
    nix =
      let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in
      {
        settings = {
          # Enable flakes and new 'nix' command
          experimental-features = "nix-command flakes";
          # Opinionated: disable global registry
          flake-registry = "";
          # Workaround for https://github.com/NixOS/nix/issues/9574
          nix-path = config.nix.nixPath;
        };
        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    nix-index.enable = lib.mkEnableOption "Enable nix-index tool for NixOS";
  };

  config = lib.mkIf config.nix-index.enable {
    programs.nix-index.enable = true;
    programs.nix-index.enableFishIntegration = true;

    # Disable command-not-found globally for flake-based systems
    programs.command-not-found.enable = false;
  };
}

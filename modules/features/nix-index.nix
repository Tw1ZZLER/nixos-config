{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nix-index = {...}: {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];
    programs = {
      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };

      # Disable command-not-found globally for flake-based systems
      command-not-found.enable = false;
    };
  };
}

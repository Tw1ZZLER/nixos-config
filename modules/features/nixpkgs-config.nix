# Global Nixpkgs config
{
  self,
  inputs,
  ...
}: let
  sharedNixpkgsConfig = {
    # Unfortunately we must allow proprietary garbage sometimes 😭😭😭
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-40.10.5"
    ];
  };
in {
  flake.nixosModules.nixpkgs-config = {...}: {
    nixpkgs.config = sharedNixpkgsConfig;
  };

  flake.homeModules.nixpkgs-config = {...}: {
    nixpkgs.config = sharedNixpkgsConfig;
  };
}

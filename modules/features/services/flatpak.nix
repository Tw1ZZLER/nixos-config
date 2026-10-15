# Enable Flatpak package manager
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.flatpak = {...}: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
      self.nixosModules.misc-usr-fix
    ];
    services.flatpak.enable = true;
  };

  flake.homeModules.flatpak = {...}: {
    imports = [
      inputs.nix-flatpak.homeModules.nix-flatpak
    ];
    services.flatpak.enable = true;
  };
}

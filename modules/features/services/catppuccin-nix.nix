# Catppuccin-specific styling, alternative to Stylix
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.catppuccin-nix = {...}: {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "red";
      nvim.enable = false;
      starship.enable = false;
    };
  };
}

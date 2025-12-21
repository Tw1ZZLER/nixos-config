# Catppuccin-specific styling, alternative to Stylix
{
  pkgs,
  libs,
  config,
  ...
}:

{
  options = {
    catppuccin.enable = lib.mkEnableOption "Enable Catppuccin theme configuration";
  };

  config = lib.mkIf config.catppuccin.enable {
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "red";
      nvim.enable = false;
      wezterm.enable = false;
      starship.enable = false;
    };
  };
}

# Catppuccin-specific styling, alternative to Stylix
{ pkgs, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "red";
    nvim.enable = false;
    wezterm.enable = false;
  };
}

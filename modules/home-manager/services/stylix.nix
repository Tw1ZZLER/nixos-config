{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    stylix.enable = lib.mkEnableOption "Enable Stylix theme manager";
  };

  config = lib.mkIf config.stylix.enable {
    stylix = {
      enable = true;

      # Catpuccin-frappe from the base16-schemes package
      base16Scheme = "${pkgs.unstable.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      polarity = "dark";

      fonts = {
        serif = {
          package = pkgs.unstable.nerd-fonts.overpass;
          name = "Overpass Nerd Font";
        };
        sansSerif = {
          package = pkgs.unstable.nerd-fonts.overpass;
          name = "Overpass Nerd Font";
        };
        monospace = {
          package = pkgs.unstable.nerd-fonts.victor-mono;
          name = "VictorMono Nerd Font";
        };
        emoji = {
          package = pkgs.unstable.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
      targets = {
        neovim.enable = false;
        wezterm.enable = false;
        starship.enable = false;
        kde.enable = true;
        gtk.enable = true;
        zen-browser = {
          enable = true;
          profileNames = [ "tw1zzler" ];
        };
      };
    };
  };
}

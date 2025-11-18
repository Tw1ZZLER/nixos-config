{ pkgs, ... }:
{
  gtk = {
    enable = true;
    # cursorTheme = {
    #   name = "catppuccin-cursors-frappe";
    #   package = pkgs.unstable.catppuccin-cursors;
    # };
    theme = {
      name = "catppuccin-frappe-blue-standard";
      package = pkgs.unstable.catppuccin-gtk;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "catppuccin-frappe";
      package = pkgs.unstable.catppuccin-qt5ct;
    };
  };

  # xdg.configFile = {
  #   "Kvantum/kvantum.kvconfig".text = ''
  #     [General]
  #     theme=GraphiteNordDark
  #   '';
  #
  #   "Kvantum/GraphiteNord".source = "${pkgs.unstable.graphite-kde-theme}/share/Kvantum/GraphiteNord";
  # };
}

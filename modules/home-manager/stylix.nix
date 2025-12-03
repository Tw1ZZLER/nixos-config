{ pkgs, ... }:
{
  stylix.targets = {
    neovim.enable = false;
    starship.enable = false;
    kde.enable = true;
    gtk.enable = true;
  };
}

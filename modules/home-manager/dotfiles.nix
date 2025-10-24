# My dotfile linking
{ ... }:
{
  xdg.configFile."fish".source = ../../dotfiles/fish;
  xdg.configFile."fastfetch".source = ../../dotfiles/fastfetch;
  xdg.configFile."yazi".source = ../../dotfiles/yazi;
  xdg.configFile."starship.toml".source = ../../dotfiles/starship.toml;
}

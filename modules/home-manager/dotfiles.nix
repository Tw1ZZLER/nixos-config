# My dotfile linking
{ ... }:
{
  xdg.configFile.fastfetch = {
    recursive = true;
    source = ../../dotfiles/fastfetch;
  };
  xdg.configFile.yazi = {
    recursive = true;
    source = ../../dotfiles/yazi;
  };
}

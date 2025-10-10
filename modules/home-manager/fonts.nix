# Enable fonts that I like
{ pkgs }:
{
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs.unstable; [
    nerd-fonts.victor-mono
    corefonts
    monocraft
  ];
}

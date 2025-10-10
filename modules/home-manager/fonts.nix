{ pkgs }:
{
  # Enable fonts
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs.unstable; [
    # Fonts
    nerd-fonts.victor-mono
    corefonts
    monocraft
  ];
}

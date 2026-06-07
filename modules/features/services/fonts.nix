# Enable custom fonts
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.fonts = {pkgs, ...}: {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.victor-mono
      corefonts
      monocraft
    ];
  };
}

# Enable Dolphin, a file manager for KDE.
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.dolphin = {pkgs, ...}: {
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.qtsvg # For support for SVG icons
      kdePackages.kio # needed since 25.11
      kdePackages.kio-fuse # to mount remote filesystems via FUSE
      kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    ];
  };
}

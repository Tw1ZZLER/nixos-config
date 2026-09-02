# Enable Zathura PDF viewer
# genAttrs usage: https://noogle.dev/f/lib/genAttrs/
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zathura = {
    pkgs,
    lib,
    ...
  }: {
    xdg.mimeApps.defaultApplications = lib.genAttrs [
      "application/pdf"
      "application/epub"
    ] (_: pkgs.zathura.meta.desktopFileName);

    programs.zathura.enable = true;
  };
}

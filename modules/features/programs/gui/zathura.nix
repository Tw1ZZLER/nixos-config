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
    xdg.mimeApps = {
      enable = true;
      defaultApplications = lib.genAttrs [
        "application/pdf"
        "application/epub"
      ] (_: "zathura.desktop");
    };
    programs.zathura.enable = true;
  };
}

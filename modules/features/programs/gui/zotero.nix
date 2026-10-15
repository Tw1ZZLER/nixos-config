# Enable Zotero
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zotero = {pkgs, ...}: {
    services.flatpak.packages = ["org.zotero.Zotero"];
  };
}

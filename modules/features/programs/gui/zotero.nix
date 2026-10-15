# Enable Zotero
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zotero = {pkgs, ...}: {
    home.packages = with pkgs; [
      zotero
    ];
  };
}

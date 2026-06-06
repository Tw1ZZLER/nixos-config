# Stuff I need for college
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.onu = {pkgs, ...}: {
    home.packages = with pkgs; [
      wpsoffice # WARN: Proprietary
      omnissa-horizon-client # WARN: Proprietary
    ];
  };
}

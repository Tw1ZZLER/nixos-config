# Enable Moonlight, a game streaming client
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.moonlight = {pkgs, ...}: {
    home.packages = [pkgs.moonlight-qt];
  };
}

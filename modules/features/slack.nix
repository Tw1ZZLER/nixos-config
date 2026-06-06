# Slack client
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.slack = {pkgs, ...}: {
    home.packages = [pkgs.slack];
  };
}

# Email /calendar
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.thunderbird = {pkgs, ...}: {
    home.packages = [pkgs.thunderbird-bin];
  };
}

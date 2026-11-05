{
  self,
  inputs,
  ...
}: {
  flake.homeModules.horizon-client = {pkgs, ...}: {
    home.packages = with pkgs; [
      omnissa-horizon-client # WARN: Proprietary
    ];
  };
}

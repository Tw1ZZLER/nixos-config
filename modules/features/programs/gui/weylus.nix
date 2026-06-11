# Enable Weylus screen sharing application
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.weylus = {...}: {
    programs.weylus = {
      enable = true;
      openFirewall = true;
      users = ["tw1zzler"];
    };
  };
}

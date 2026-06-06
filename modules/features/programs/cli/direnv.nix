# Enable direnv, an environment switcher for the shell
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.direnv = {...}: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

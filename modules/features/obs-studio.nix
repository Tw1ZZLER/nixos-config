# Enable OBS Studio
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.obs-studio = {...}: {
    programs.obs-studio.enable = true;
  };
}

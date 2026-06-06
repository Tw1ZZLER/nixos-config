# Enable MPV media player
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mpv = {...}: {
    programs.mpv.enable = true;
  };
}

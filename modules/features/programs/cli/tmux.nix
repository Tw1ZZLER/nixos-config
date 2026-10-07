# terminal multiplexer
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.tmux = {...}: {
    programs.tmux.enable = true;
  };
}

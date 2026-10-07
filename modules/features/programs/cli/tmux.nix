# terminal multiplexer
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.tmux = {pkgs, ...}: {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        resurrect
        continuum
        yank
        sensible
        tmux-which-key
      ];
    };
  };
}

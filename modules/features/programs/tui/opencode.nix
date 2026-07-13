# Opencode, terminal-based AI agent
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
    };
  };
}

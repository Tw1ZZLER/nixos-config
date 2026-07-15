# Opencode, terminal-based AI agent
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        "$schema" = "https://opencode.ai/config.json";

        # Safety and anti-telemetry settings
        share = "disabled";
        autoupdate = "notify";
        permission = {
          edit = "ask";
        };
        experimental = {
          openTelemetry = false;
        };
      };
    };
  };
}

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

        # Models and inference providers
        enabled_providers = [
          "argo"
        ];
        provider = {
          argo = {
            npm = "@ai-sdk/openai-compatible";
            name = "Argo Gateway API";
            options = {
              baseURL = inputs.nix-secrets.argo.base-url;
              headers = {
                Authorization = inputs.nix-secrets.argo.auth;
              };
            };
            models = {
              # OPENAI MODELS
              gpt54 = {
                name = "GPT-5.4";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };

              # ANTHROPIC MODELS
              claudeopus48 = {
                name = "Claude Opus 4.8";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
              claudeopus47 = {
                name = "Claude Opus 4.7";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
              claudeopus46 = {
                name = "Claude Opus 4.6";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
              claudesonnet46 = {
                name = "Claude Sonnet 4.6";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
              claudehaiku45 = {
                name = "Claude Haiku 4.5";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };

              # GOOGLE MODELS
              gemini31flashlite = {
                name = "Gemini 3.1 Flash Lite";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
              gemini35flash = {
                name = "Gemini 3.5 Flash";
                modalities = {
                  input = [
                    "text"
                    "image"
                  ];
                  output = [
                    "text"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}

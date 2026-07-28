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
        provider = let
          text-image-text-modality = {
            input = [
              "text"
              "image"
            ];
            output = [
              "text"
            ];
          };
        in {
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
              gpt56sol = {
                name = "GPT-5.6 Sol";
                modalities = text-image-text-modality;
              };
              gpt56terra = {
                name = "GPT-5.6 Terra";
                modalities = text-image-text-modality;
              };
              gpt56luna = {
                name = "GPT-5.6 Luna";
                modalities = text-image-text-modality;
              };
              gpt55 = {
                name = "GPT-5.5";
                modalities = text-image-text-modality;
              };
              gpt54 = {
                name = "GPT-5.4";
                modalities = text-image-text-modality;
              };
              gpt54mini = {
                name = "GPT-5.4 mini";
                modalities = text-image-text-modality;
              };
              gpt54nano = {
                name = "GPT-5.4 nano";
                modalities = text-image-text-modality;
              };

              # ANTHROPIC MODELS
              claudeopus48 = {
                name = "Claude Opus 4.8";
                modalities = text-image-text-modality;
              };
              claudeopus47 = {
                name = "Claude Opus 4.7";
                modalities = text-image-text-modality;
              };
              claudeopus46 = {
                name = "Claude Opus 4.6";
                modalities = text-image-text-modality;
              };
              claudesonnet5 = {
                name = "Claude Sonnet 5";
                modalities = text-image-text-modality;
              };
              claudesonnet46 = {
                name = "Claude Sonnet 4.6";
                modalities = text-image-text-modality;
              };
              claudehaiku45 = {
                name = "Claude Haiku 4.5";
                modalities = text-image-text-modality;
              };

              # GOOGLE MODELS
              gemini31flashlite = {
                name = "Gemini 3.1 Flash Lite";
                modalities = text-image-text-modality;
              };
              gemini35flash = {
                name = "Gemini 3.5 Flash";
                modalities = text-image-text-modality;
              };
            };
          };
        };
      };
    };
  };
}

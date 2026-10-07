# Pi, terminal-based fully-featured AI harness
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.pi = {...}: {
    programs.pi-coding-agent = {
      enable = true;
      # providers = {
      #   llama-cpp = {
      #     api = "openai-completions";
      #     apiKey = "no-key-required";
      #     baseUrl = "http://${inputs.nix-secrets.ip-address.vpn.redmond}:8080";
      #     models = [
      #       # {
      #       #   id = "";
      #       # }
      #     ];
      #   };
      # };
    };
  };
}

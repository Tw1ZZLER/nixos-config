{
  self,
  inputs,
  ...
}: {
  flake.homeModules.git = {...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Corbin";
          email = inputs.nix-secrets.emails.gitHub;
        };
      };
      signing = {
        format = "ssh";
        key = inputs.nix-secrets.keys.gitSigning;
        signByDefault = true;
      };
    };

    programs.lazygit = {
      enable = true;
      settings.git.overrideGpg = true;
    };
  };
}

# Enable Noctalia Shell
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.noctalia-shell = {...}: {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = ./noctalia-config.toml;
    };
  };
}

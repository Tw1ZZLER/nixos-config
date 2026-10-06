# Enable Noctalia Shell
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.noctalia-shell = {lib, ...}: {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = lib.mkForce (fromTOML (builtins.readFile ./noctalia-config.toml));
    };
  };
}

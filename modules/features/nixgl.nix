# Enable NixGL for OpenGL support on non-NixOS systems
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nixgl = {...}: let
    nixglPkgs = inputs.nixgl.packages;
  in {
    # NixGL settings
    targets.genericLinux.nixGL = {
      packages = nixglPkgs;
      defaultWrapper = "mesa";
      installScripts = ["mesa"];
    };
  };
}

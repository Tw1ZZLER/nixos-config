# Enable NixGL for OpenGL support on non-NixOS systems
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nixgl = {...}: {
    # NixGL settings
    targets.genericLinux.nixGL = {
      packages = inputs.nixgl.packages;
      defaultWrapper = "mesa";
      installScripts = ["mesa"];
    };
  };
}

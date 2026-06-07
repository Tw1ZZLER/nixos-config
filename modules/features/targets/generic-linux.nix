{
  self,
  inputs,
  ...
}: {
  flake.homeModules.generic-linux = {...}: {
    # Enable settings that make Home Manager work better on GNU/Linux distributions other than NixOS.
    targets.genericLinux.enable = true;

    # Enable GPU driver integration for non-NixOS systems
    # Requires root access
    targets.genericLinux.gpu.enable = true;
  };
}

{
  pkgs,
  lib,
  config,
  ...
}@args:
{
  options = {
    prismlauncher.enable = lib.mkEnableOption "Enable Prism Launcher, the launcher for Minecraft.";
  };

  config = lib.mkIf config.prismlauncher.enable {
    home.packages =
      with pkgs.unstable;
      (
        # We are using lib.optionals here to conditionally wrap the application with nixGL, based on the presence of osConfig argument.
        # osConfig tells us if we are on a NixOS or non-NixOS system.
        # non-NixOS systems need nixGL to properly handle OpenGL
        lib.optionals (!(args ? osConfig)) [
          (config.lib.nixGL.wrap (
            prismlauncher.override {
              jdks = [
                (config.lib.nixGL.wrap jdk25)
                (config.lib.nixGL.wrap jdk21)
                (config.lib.nixGL.wrap jdk17)
                (config.lib.nixGL.wrap jdk8)
              ];
            }
          ))
        ]

        # If osConfig is present, we are on NixOS and do not need nixGL wrapping the packages
        ++ lib.optionals (args ? osConfig) [
          (prismlauncher.override {
            jdks = [
              jdk25
              jdk21
              jdk17
              jdk8
            ];
          })
        ]
      );
  };
}

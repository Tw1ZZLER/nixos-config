{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    prismlauncher.enable = lib.mkEnableOption "Enable Prism Launcher, the launcher for Minecraft.";
  };

  config = lib.mkIf config.prismlauncher.enable {
    home.packages = with pkgs.unstable; [
      (prismlauncher.override {
        # Change Java runtimes available to Prism Launcher
        jdks = [
          jdk25
          jdk21
          jdk17
          jdk8
        ];
      })
    ];
  };
}

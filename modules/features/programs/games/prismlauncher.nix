# Enable Prism Launcher, the launcher for Minecraft.
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.prismlauncher = {pkgs, ...}: {
    programs.prismlauncher.enable = true;
    home.file = with pkgs.javaPackages.compiler.temurin-bin; {
      ".local/share/PrismLauncher/java/jdk8".source = jre-8;
      ".local/share/PrismLauncher/java/jdk17".source = jre-17;
      ".local/share/PrismLauncher/java/jdk21".source = jre-21;
      ".local/share/PrismLauncher/java/jdk26".source = jre-26;
    };
  };
}

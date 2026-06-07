# Enable Prism Launcher, the launcher for Minecraft.
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.prismlauncher = {pkgs, ...}: {
    programs.prismlauncher.enable = true;
    home.file = {
      ".local/share/PrismLauncher/java/jdk8".source = pkgs.jdk8;
      ".local/share/PrismLauncher/java/jdk17".source = pkgs.jdk17;
      ".local/share/PrismLauncher/java/jdk21".source = pkgs.jdk21;
      ".local/share/PrismLauncher/java/jdk25".source = pkgs.jdk25;
    };
  };
}

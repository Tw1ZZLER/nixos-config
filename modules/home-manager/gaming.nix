# Gaming tools, games, etc.
{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    moonlight-qt
    clonehero # WARN: Proprietary
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
}

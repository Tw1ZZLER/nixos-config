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

  # This module does not actually wrap Prism Launcher itself with nixGL, as it does
  # not need it. Rather, the Java binaries that Prism launches need to be wrapped
  # to work properly on non-NixOS distros.
  flake.homeModules.prismlauncher-nixgl = {
    config,
    lib,
    pkgs,
    ...
  }: let
    # Helper to build a mock JDK directory structure with a wrapped java binary inside
    fakeJDKDir = name: jdkPkg: let
      wrappedJava = config.lib.nixGL.wrap (
        pkgs.writeShellScriptBin "java" ''
          exec ${jdkPkg}/bin/java "$@"
        ''
      );
    in
      pkgs.runCommand "fake-${name}" {} ''
        mkdir -p $out/bin
        # Link the NixGL wrapped script as the primary binary
        ln -s ${wrappedJava}/bin/java $out/bin/java

        # Pass-through other essential JDK metadata files so Prism recognizes it
        if [ -d ${jdkPkg}/lib ]; then ln -s ${jdkPkg}/lib $out/lib; fi
        if [ -f ${jdkPkg}/release ]; then ln -s ${jdkPkg}/release $out/release; fi
      '';
  in {
    # On non-NixOS, link our fake JDK directories instead
    home.file = {
      ".local/share/PrismLauncher/java/jdk8".source = lib.mkForce (fakeJDKDir "jdk8" pkgs.jdk8);
      ".local/share/PrismLauncher/java/jdk17".source = lib.mkForce (fakeJDKDir "jdk17" pkgs.jdk17);
      ".local/share/PrismLauncher/java/jdk21".source = lib.mkForce (fakeJDKDir "jdk21" pkgs.jdk21);
      ".local/share/PrismLauncher/java/jdk25".source = lib.mkForce (fakeJDKDir "jdk25" pkgs.jdk25);
    };
  };
}

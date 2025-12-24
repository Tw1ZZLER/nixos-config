# Printing stuff
# https://nixos.wiki/wiki/Printing
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    printing.enable = lib.mkEnableOption "Enable CUPS printing services";
  };
  config = lib.mkIf config.printing.enable {
    # CUPS (printing)
    services = {
      printing = {
        enable = true;

        drivers = with pkgs; [
          # Foomatic Printer Drivers
          foomatic-db-nonfree
          foomatic-db-engine
          foomatic-db-ppds-withNonfreeDb

          # GhostScript and CUPS printer drivers
          gutenprint

          # HP Printer Drivers
          hplip

          # Samsung Printer Drivers
          splix

          # ASCII to PostScript converter and pretty-printer
          a2ps

          # CUPS and related packages
          cups
          cups-filters
          cups-pk-helper

          # PostScript interpreter
          ghostscript
        ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # GTK GUI app for printer configuration
      system-config-printer
    ];
  };
}

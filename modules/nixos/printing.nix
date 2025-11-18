# Printing stuff
# https://nixos.wiki/wiki/Printing
{ pkgs, ... }:
{
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
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # ASCII to PostScript converter and pretty-printer
    a2ps

    # CUPS and related packages
    cups
    cups-filters
    cups-pk-helper

    # PostScript interpreter
    ghostscript

    # GTK GUI app for printer configuration
    system-config-printer

    # KDE app for printer configuration
    kdePackages.print-manager
  ];

  hardware.printers = {
    ensurePrinters = [
      # ONU Printers
      {
        name = "onu-bw";
        description = "ONU Black and White Printer";
        location = "ONU";
        deviceUri = "smb://onuprinters.onu.edu/Black-and-White";
        model = "drv:///sample.drv/generpcl.ppd";
        ppdOptions = {
          AuthInfoRequired = "username,password"; # DANGER: Credentials in plain text
        };
      }
      {
        name = "onu-color";
        description = "ONU Color Printer";
        location = "ONU";
        deviceUri = "smb://onuprinters.onu.edu/Color";
        model = "drv:///sample.drv/generpcl.ppd";
        ppdOptions = {
          AuthInfoRequired = "username,password"; # DANGER: Credentials in plain text
        };
      }
    ];
    ensureDefaultPrinter = "onu-bw";
  };
}

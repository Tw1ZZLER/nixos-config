# Enable Argonne Printers Configuration
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.argonne-printers = {...}: {
    hardware.printers.ensurePrinters = [
      # Argonne Printers
      {
        name = "argonne-dekalb";
        description = "Argonne Dekalb Printer";
        location = "5618 (East Oasis)";
        deviceUri = "lpd://printers.anl.gov/Dekalb";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          AuthInfoRequired = "username,password";
        };
      }
    ];
  };
}

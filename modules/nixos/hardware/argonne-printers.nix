{ lib, config, ... }:
{
  options = {
    argonne-printers.enable = lib.mkEnableOption "Enable Argonne Printers configuration";
  };
  config = lib.mkIf config.argonne-printers.enable {
    hardware.printers = {
      ensurePrinters = [
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
  };
}

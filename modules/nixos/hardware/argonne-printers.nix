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
          name = "argonne-niagarafalls";
          description = "Argonne NiagaraFalls Printer";
          location = "5C5";
          deviceUri = "lpd://printers.anl.gov/NiagaraFalls";
          model = "drv:///sample.drv/generic.ppd";
          ppdOptions = {
            AuthInfoRequired = "username,password";
          };
        }
      ];
    };
  };
}

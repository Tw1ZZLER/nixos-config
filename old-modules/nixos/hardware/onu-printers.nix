{ lib, config, ... }:
{
  options = {
    onu-printers.enable = lib.mkEnableOption "Enable ONU Printers configuration";
  };
  config = lib.mkIf config.onu-printers.enable {
    hardware.printers = {
      ensurePrinters = [
        # ONU Printers
        {
          name = "onu-bw";
          description = "ONU Black and White Printer";
          location = "ONU";
          deviceUri = "smb://onuprinters.onu.edu/Black-and-White";
          model = "foomatic-db-ppds/KONICA_MINOLTA-bizhub_C352-Postscript-KONICA_MINOLTA.ppd.gz";
          ppdOptions = {
            AuthInfoRequired = "username,password";
          };
        }
        {
          name = "onu-color";
          description = "ONU Color Printer";
          location = "ONU";
          deviceUri = "smb://onuprinters.onu.edu/Color";
          model = "foomatic-db-ppds/KONICA_MINOLTA-bizhub_C352-Postscript-KONICA_MINOLTA.ppd.gz";
          ppdOptions = {
            AuthInfoRequired = "username,password";
          };
        }
      ];
      ensureDefaultPrinter = "onu-bw";
    };
  };
}

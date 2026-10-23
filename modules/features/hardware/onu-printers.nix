# Enable ONU printers configuration
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.onu-printers = {...}: {
    hardware.printers = {
      ensurePrinters = [
        # ONU Printers
        {
          name = "onu-bw";
          description = "ONU Black and White Printer";
          location = "ONU";
          deviceUri = "smb://onuprinters.onu.edu/Black-and-White";
          model = "drv:///sample.drv/generic.ppd";
          ppdOptions = {
            AuthInfoRequired = "username,password";
          };
        }
        {
          name = "onu-color";
          description = "ONU Color Printer";
          location = "ONU";
          deviceUri = "smb://onuprinters.onu.edu/Color";
          model = "drv:///sample.drv/generic.ppd";
          ppdOptions = {
            AuthInfoRequired = "username,password";
          };
        }
      ];
      ensureDefaultPrinter = "onu-bw";
    };
  };
}

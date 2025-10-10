{ }:
{
  # Syncthing
  services.syncthing = {
    enable = true;
    tray.enable = true;
    # overrideFolders = false; # can be used to turn off the auto restart thing
    # overrideDevices = false; # where devices and folders are deleted on switch
    settings = {
      options = {
        relaysEnabled = false;
        globalAnnounceEnabled = false;
        urAccepted = -1;
      };
      devices = {
        "Pixel 8" = {
          addresses = [ "tcp://100.67.233.82:22000" ];
          id = "K6ZAYPE-YSJ7ILX-2XARZW7-HVKS76J-7YSAJM5-7K6TQ7H-LHQ5U4A-4EPXOQR";
        };
        "iPad" = {
          addresses = [ "tcp://100.85.218.3:22000" ];
          id = "YJ74BBR-KYOX2GQ-WE6EPHY-WE6Y3DH-VEP6CFU-HATBP5G-U6VZMUS-BP4ALAA";
        };
        "REDMOND" = {
          addresses = [ "tcp://100.80.238.41:22000" ];
          id = "XVSUFJ6-DF5JJZU-ETJXMWT-XOFGOJ7-UJLGDLQ-MGMS2C3-HCJHTBM-F4E74QH";
        };
      };
      folders = {
        "Vaults" = {
          path = "/home/tw1zzler/vault";
          id = "ncpx4-79bk4";
          devices = [
            "REDMOND"
            "iPad"
            "Pixel 8"
          ];
        };
        "PrismLauncher" = {
          path = "/home/tw1zzler/.local/share/PrismLauncher";
          id = "ec4nk-gwpbm";
          devices = [ "REDMOND" ];
        };
      };
    };
  };

}

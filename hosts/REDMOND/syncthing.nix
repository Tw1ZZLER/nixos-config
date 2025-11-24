# File syncing tool Syncthing
{ ... }:
{
  services.syncthing = {
    enable = true;
    # tray.enable = true;
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
        "PRIMUS" = {
          addresses = [ "tcp://100.110.251.51:22000" ];
          id = "3OVXJ5E-MQ6BHCH-E67ZDZ7-U7APMIB-CSVGNXU-S5BS5DU-XWIWMY3-BKPETA2";
        };
      };
      folders = {
        "Vaults" = {
          path = "/home/tw1zzler/vault";
          id = "ncpx4-79bk4";
          devices = [
            "PRIMUS"
            "iPad"
            "Pixel 8"
          ];
        };
        "PrismLauncher" = {
          path = "/home/tw1zzler/BIGDATA/PrismLauncher";
          id = "ec4nk-gwpbm";
          devices = [ "PRIMUS" ];
        };
      };
    };
  };

}

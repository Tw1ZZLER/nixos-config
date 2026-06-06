{
  config,
  pkgs,
  lib,
  ...
}:

let
  hostName =
    if config.syncthing.hostName != null then config.syncthing.hostName else config.networking.hostName;
in
{
  options = {
    syncthing.enable = lib.mkEnableOption "Enable Syncthing, a continuous file synchronization program. (My wrapper)";
    syncthing.hostName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Override host name for Syncthing configuration (useful for non-NixOS hosts)";
    };
  };

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
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
          "REDMOND" = {
            addresses = [ "tcp://100.80.238.41:22000" ];
            id = "XVSUFJ6-DF5JJZU-ETJXMWT-XOFGOJ7-UJLGDLQ-MGMS2C3-HCJHTBM-F4E74QH";
          };
        };
        folders = {
          "Vaults" = {
            path = "/home/tw1zzler/vault";
            id = "ncpx4-79bk4";
            devices =
              if hostName == "REDMOND" then
                [
                  "PRIMUS"
                  "iPad"
                  "Pixel 8"
                ]
              else if hostName == "PRIMUS" then
                [
                  "REDMOND"
                  "iPad"
                  "Pixel 8"
                ]
              else
                [
                  "PRIMUS"
                  "REDMOND"
                  "iPad"
                  "Pixel 8"
                ];
          };
          "PrismLauncher" = {
            path =
              if hostName == "REDMOND" then
                "/home/tw1zzler/BIGDATA/PrismLauncher"
              else
                "/home/tw1zzler/.local/share/PrismLauncher";
            id = "ec4nk-gwpbm";
            devices =
              if hostName == "REDMOND" then
                [ "PRIMUS" ]
              else if hostName == "PRIMUS" then
                [ "REDMOND" ]
              else
                [
                  "PRIMUS"
                  "REDMOND"
                ];
          };
        };
      };
    };
  };
}

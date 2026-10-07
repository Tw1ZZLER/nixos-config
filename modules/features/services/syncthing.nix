{
  self,
  inputs,
  ...
}: {
  flake.homeModules.syncthing = {
    config,
    lib,
    ...
  }: let
    # Using 'or null' prevents evaluation from crashing on non-NixOS machines
    hostName =
      if config.syncthing.hostName != null
      then config.syncthing.hostName
      else config.networking.hostName or null;
  in {
    options = {
      syncthing.hostName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Override host name for Syncthing configuration (useful for non-NixOS hosts)";
      };
    };

    config = {
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
              addresses = ["tcp://${inputs.nix-secrets.ip-address.vpn.pixel-8}:22000"];
              id = "K6ZAYPE-YSJ7ILX-2XARZW7-HVKS76J-7YSAJM5-7K6TQ7H-LHQ5U4A-4EPXOQR";
            };
            "iPad" = {
              addresses = ["tcp://${inputs.nix-secrets.ip-address.vpn.ipad-gen-6}:22000"];
              id = "YJ74BBR-KYOX2GQ-WE6EPHY-WE6Y3DH-VEP6CFU-HATBP5G-U6VZMUS-BP4ALAA";
            };
            "PRIMUS" = {
              addresses = ["tcp://${inputs.nix-secrets.ip-address.vpn.primus}:22000"];
              id = "3OVXJ5E-MQ6BHCH-E67ZDZ7-U7APMIB-CSVGNXU-S5BS5DU-XWIWMY3-BKPETA2";
            };
            "REDMOND" = {
              addresses = ["tcp://${inputs.nix-secrets.ip-address.vpn.redmond}:22000"];
              id = "XVSUFJ6-DF5JJZU-ETJXMWT-XOFGOJ7-UJLGDLQ-MGMS2C3-HCJHTBM-F4E74QH";
            };
          };
          folders = {
            "Vaults" = {
              path = "/home/tw1zzler/vault";
              id = "ncpx4-79bk4";
              devices =
                if hostName == "REDMOND"
                then [
                  "PRIMUS"
                  "iPad"
                  "Pixel 8"
                ]
                else if hostName == "PRIMUS"
                then [
                  "REDMOND"
                  "iPad"
                  "Pixel 8"
                ]
                else [
                  "PRIMUS"
                  "REDMOND"
                  "iPad"
                  "Pixel 8"
                ];
            };
            "PrismLauncher" = {
              path =
                if hostName == "REDMOND"
                then "/home/tw1zzler/BIGDATA/PrismLauncher"
                else "/home/tw1zzler/.local/share/PrismLauncher";
              id = "ec4nk-gwpbm";
              devices =
                if hostName == "REDMOND"
                then ["PRIMUS"]
                else if hostName == "PRIMUS"
                then ["REDMOND"]
                else [
                  "PRIMUS"
                  "REDMOND"
                ];
            };
          };
        };
      };
    };
  };
}

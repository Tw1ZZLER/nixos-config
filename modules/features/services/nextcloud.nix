# Enable Nextcloud service
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nextcloud = {
    config,
    pkgs,
    ...
  }: {
    environment.etc."nextcloud-admin-pass".text = "PWD";

    networking.firewall = {
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [53];
      allowedTCPPorts = [53];
    };

    services.pihole-ftl = {
      enable = true;
      settings = {
        dns = {
          upstreams = ["1.1.1.1" "8.8.8.8"];

          hosts = [
            "100.83.191.106 cloud.tw1zzler.net"
            "100.83.191.106 pihole.tw1zzler.net"
          ];
        };
      };
    };

    services.pihole-web = {
      enable = true;
      ports = [8081];
      hostName = "pihole.tw1zzler.net";
    };

    services.nginx.virtualHosts."pihole.tw1zzler.net" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8081/admin/";
        proxyWebsockets = true;
      };
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud34;

      hostName = "cloud.tw1zzler.net";

      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
      };
      extraAppsEnable = true;

      settings = {
        maintenance_window_start = 1;
        default_phone_region = "DE";
        log_type = "systemd";
        serverid = 0;

        trusted_domains = [
          "cloud.tw1zzler.net"
        ];
      };
    };
  };
}

# Enable Pi-hole service
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.pi-hole = {...}: {
    # Dusable systemd-resolved for better DNS handling
    services.resolved.enable = false;
    networking.nameservers = ["1.1.1.1" "8.8.8.8"];

    networking.firewall = {
      enable = true;
      allowedUDPPorts = [53 80 443];
      allowedTCPPorts = [53 80 443];
      trustedInterfaces = ["tailscale0"];
    };

    services.pihole-ftl = {
      enable = true;
      settings = {
        dns = {
          upstreams = ["1.1.1.1" "8.8.8.8"];
          listeningBehavior = "all";
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
  };
}

# Enable Pi-hole service
# credit: https://nixos.wiki/wiki/Pi-hole
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.pi-hole = {...}: {
    networking = {
      nameservers = ["1.1.1.1" "8.8.8.8"];
      firewall.trustedInterfaces = ["tailscale0"];
      hosts = {
        "100.83.191.106" = ["cloud.tw1zzler.net" "cloud" "pi-hole.tw1zzler.net" "pi-hole"];
      };
    };

    services = {
      dnsmasq = {
        enable = false;
        settings = {
          address = [
            "/feelinsonice-hrd.appspot.com/ # Block Snapchat"
            "/feelinsonice.appspot.com/ # Block Snapchat"
            "/snapchat.com/ # Block Snapchat"
          ];
          dhcp-name-match = [
            "set:hostname-ignore,wpad"
            "set:hostname-ignore,localhost"
          ];
          # Set DHCP option 6 to the DNS server you nodes should use.
          dhcp-option = [
            "vendor:MSFT,2,1i"
            "6,100.83.191.106"
          ];
          domain = [
            "tw1zzler.net,100.83.191.106/32,local"
          ];
        };
      };

      pihole-ftl = {
        enable = true;
        lists = [
          # {
          #   url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          #   type = "block";
          #   enabled = true;
          #   description = "Steven Black's HOSTS";
          # }
        ];
        openFirewallDNS = true;
        openFirewallDHCP = true;
        openFirewallWebserver = true;
        queryLogDeleter.enable = true;
        settings = {
          dns = {
            domain = "tw1zzler.net";
            domainNeeded = true;
            expandHosts = true;
            listeningMode = "LOCAL";
            hosts = [
              "100.83.191.106 cloud"
              "100.83.191.106 pihole"
            ];
            upstreams = ["1.1.1.1" "8.8.8.8"];
          };
        };
        useDnsmasqConfig = true;
      };

      pihole-web = {
        enable = true;
        ports = [8081];
        hostName = "pihole.tw1zzler.net";
      };

      resolved = {
        # enable = false;
        settings = {
          Resolve = {
            DNSStubListener = false;
            MulticastDNS = false;
          };
        };
      };

      nginx.virtualHosts."pihole.tw1zzler.net" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8081/admin/";
          proxyWebsockets = true;
        };
      };
    };

    system.activationScripts = {
      print-pi-hole = {
        text = builtins.trace "building the pi-hole configuration..." "";
      };
    };

    #
    # Systemd
    #
    # The following silences a benign FTL.log warning:
    # WARNING API: Failed to read /etc/pihole/versions (key: internal_error)
    systemd.tmpfiles.rules = [
      # Type Path Mode User Group Age Argument
      "f /etc/pihole/versions 0644 pihole pihole - -"
    ];
  };
}

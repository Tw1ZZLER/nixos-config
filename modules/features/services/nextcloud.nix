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
  }: let
    hostName = "cloud.tw1zzler.net";
  in {
    environment.etc."nextcloud-admin-pass".text = "PWD";

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud34;

      inherit hostName;
      https = true;

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
          hostName
        ];
      };
    };

    # Let's Encrypt via Cloudflare DNS-01 (works with Tailscale-only A records).
    # Expects a sops secret whose contents are an environment file:
    #   CLOUDFLARE_DNS_API_TOKEN=...
    security.acme = {
      acceptTerms = true;
      defaults.email = inputs.nix-secrets.emails.personal;

      certs.${hostName} = {
        dnsProvider = "cloudflare";
        # environmentFile = config.sops.secrets.cloudflare-dns-api-token.path;
        group = "nginx";
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts.${hostName} = {
        forceSSL = true;
        enableACME = true;
        # Required for DNS-01 (skip HTTP challenge webroot).
        acmeRoot = null;
      };
    };

    users.users.nginx.extraGroups = ["acme"];

    networking.firewall.allowedTCPPorts = [80 443];
  };
}

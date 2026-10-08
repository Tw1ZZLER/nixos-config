# Enable Vaultwarden service
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vaultwarden = {
    config,
    pkgs,
    ...
  }: {
    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";

      # Environment file for secrets like ADMIN_TOKEN (optional)
      # environmentFile = "/var/lib/vaultwarden/vaultwarden.env";

      config = {
        DOMAIN = "https://vault.tw1zzler.net";
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        SIGNUPS_ALLOWED = true;
      };
    };

    # 2. Configure ACME / Let's Encrypt for automatic HTTPS certificates
    security.acme = {
      acceptTerms = true;
      defaults.email = inputs.nix-secrets.emails.personal;
    };

    # 3. Nginx Reverse Proxy with WebSocket support
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedGzipSettings = true;

      virtualHosts."vault.tw1zzler.net" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          proxyWebsockets = true; # Required for live sync push notifications
        };
      };
    };

    # Open HTTP and HTTPS ports for Let's Encrypt verification & client access
    networking.firewall.allowedTCPPorts = [80 443];

    # 1. Ensure restic package and sqlite tools are installed
    environment.systemPackages = with pkgs; [restic sqlite];

    # 2. Automated Restic Backup
    services.restic.backups.vaultwarden = {
      # Specify when the backup runs (Systemd calendar syntax)
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };

      # Set where to store backups (e.g., local external drive or remote repo)
      repository = "/var/backups/vaultwarden"; # Or "s3:https://s3.amazonaws.com/my-bucket"

      # Password file for encrypting the restic repository
      passwordFile = "/var/lib/secrets/restic-password";

      # Paths to back up: Vaultwarden database, attachments, and secrets
      paths = [
        "/var/lib/vaultwarden"
      ];

      # Safely freeze/dump SQLite database right before restic runs
      backupPrepareCommand = ''
        # Optional: Safely create a live SQLite dump without stopping Vaultwarden
        ${pkgs.sqlite}/bin/sqlite3 /var/lib/vaultwarden/db.sqlite3 ".backup '/var/lib/vaultwarden/db.sqlite3.bak'"
      '';

      # Prune old backups automatically (Keep last 7 daily, 4 weekly, 12 monthly)
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
      ];
    };
  };
}

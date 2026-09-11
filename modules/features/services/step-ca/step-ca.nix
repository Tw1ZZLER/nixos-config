# Enable step-ca service for certificates
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.step-ca = {...}: {
    # 1. Configure the step-ca service
    services.step-ca = {
      enable = true;
      address = "127.0.0.1";
      port = 8443;
      intermediatePasswordFile = "/var/lib/step-ca/password.txt";
      # settings = builtins.fromJSON (builtins.readFile ./)
      # configFile = "/var/lib/step-ca/config/ca.json";
    };

    # 2. Tell NixOS to trust step-ca Root CA system-wide
    security.pki.certificateFiles = [
      "/var/lib/step-ca/certs/root_ca.crt"
    ];

    # 3. Configure ACME client to obtain certs from step-ca
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "admin@tw1zzler.net";
        server = "https://127.0.0.1:8443/acme/acme/directory";
      };
    };

    # 5. Configure Nginx with ACME automatic cert issuance
    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      virtualHosts."tw1zzler.net" = {
        forceSSL = true;
        enableACME = true; # Requests cert automatically from local step-ca
      };
    };

    # Grant Nginx access to ACME certificates
    users.users.nginx.extraGroups = ["acme"];

    networking.firewall.allowedTCPPorts = [80 443 8443];
  };
}

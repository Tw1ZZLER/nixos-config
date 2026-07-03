# WiFi configuration for MALENIA using iwd + sops-nix
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.malenia-wifi = {config, pkgs, ...}: {
    networking.wireless.enable = false;
    networking.wireless.iwd = {
      enable = true;
      settings = {
        Network = {
          EnableIPv6 = true;
          RoutePriorityOffset = 300;
        };
        Settings.AutoConnect = true;
      };
    };

    systemd.network.networks."25-wireless" = {
      matchConfig.Name = "wl*";
      networkConfig.DHCP = "ipv4";
    };

    systemd.services.iwd-wifi-superbad = {
      description = "Configure iwd WiFi network Superbad from sops secret";
      wantedBy = ["multi-user.target"];
      before = ["iwd.service"];
      path = [pkgs.coreutils];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        mkdir -p /var/lib/iwd
        {
          echo "[Settings]"
          echo "AutoConnect=true"
          echo ""
          echo "[Security]"
          echo "Passphrase=$(cat ${config.sops.secrets.malenia-wifi-superbad-psk.path})"
        } > /var/lib/iwd/Superbad.psk
        chmod 600 /var/lib/iwd/Superbad.psk
      '';
    };
  };
}

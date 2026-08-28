# Enable Nextcloud service
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nextcloud = {config, pkgs, ...}: {
    environment.etc."nextcloud-admin-pass".text = "PWD";
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud34;
      hostName = "localhost";
      config.adminpassFile = "/etc/nextcloud-admin-pass";
      config.dbtype = "sqlite";

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
      };
      extraAppsEnable = true;

      settings = {
        # Some sane defaults required to satisfy Nextcloud configuration check
        maintenance_window_start = 1;
        default_phone_region = "DE";
        log_type = "systemd";
        serverid = 0;
      };
    };
  };
}

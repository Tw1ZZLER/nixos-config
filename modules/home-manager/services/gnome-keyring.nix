{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    gnome-keyring.enable = lib.mkEnableOption "Enable GNOME Keyring for managing secrets and SSH keys, works best with COSMIC DE.";
  };

  config = lib.mkIf config.gnome-keyring.enable {
    # Enable GNOME keyring (works best with COSMIC DE)
    services.gnome-keyring = {
      enable = true;
      components = [
        "secrets"
        "ssh"
      ];
    };
  };
}

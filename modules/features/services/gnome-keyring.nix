# Enable GNOME Keyring for managing secrets and SSH keys, works best with COSMIC DE
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.gnome-keyring = {...}: {
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

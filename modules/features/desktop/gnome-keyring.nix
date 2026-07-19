# Enable GNOME Keyring for managing secrets and SSH keys
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.gnome-keyring = {...}: {
    # Enable GNOME keyring
    services.gnome-keyring = {
      enable = true;
      components = [
        "secrets"
        "ssh"
      ];
    };
  };
}

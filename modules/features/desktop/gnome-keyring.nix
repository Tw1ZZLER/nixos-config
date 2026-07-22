# Enable GNOME Keyring for managing secrets (SSH agent is handled by rbw)
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
      ];
    };
  };
}

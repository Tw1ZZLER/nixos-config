{ pkgs, ... }:
{
  imports = [
    # Flatpak is required to install our COSMIC applets
    ./flatpak.nix
  ];

  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "tw1zzler";
  };

  # Fix Wayland clipboard (decreases security)
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.systemPackages = with pkgs; [
    # COSMIC applets and Flatpak store
    cosmic-store
  ];

  # Enable Seahorse for keyring management
  programs.seahorse.enable = true;
}

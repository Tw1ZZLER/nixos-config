{ pkgs, ... }:
{
  imports = [
    # Flatpak is required to install our COSMIC applets
    ./flatpak.nix
  ];

  # Enable the COSMIC login manager
  services = {
    displayManager = {
      cosmic-greeter = {
        enable = true;
        package = pkgs.unstable.cosmic-greeter;
      };
      autoLogin = {
        enable = true;
        user = "tw1zzler";
      };
    };

    # Enable the COSMIC desktop environment
    desktopManager.cosmic.enable = true;
  };

  environment = {
    # Fix Wayland clipboard (decreases security)
    sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

    systemPackages = with pkgs; [
      # COSMIC applets and Flatpak store
      unstable.cosmic-store

      # Other Wayland clipboard stuff
      wl-clipboard
      cliphist
    ];
  };

  # Enable Seahorse for keyring management
  programs.seahorse.enable = true;
}

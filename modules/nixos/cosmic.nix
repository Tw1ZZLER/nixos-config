{ pkgs, ... }:
{
  # Flatpak is required to install our COSMIC applets
  flatpak.enable = true;

  # Use Seahorse for key management

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

    # Fix shutdown timing out for COSMIC sessions
    # logind.extraConfig = ''
    #   KillUserProcesses=yes
    # '';
  };

  environment = {
    sessionVariables = {
      # Fix Wayland clipboard (decreases security)
      COSMIC_DATA_CONTROL_ENABLED = 1;
      # Wayland support for Electron and Chromium
      NIXOS_OZONE_WL = "1";
      # Fix COSMIC Screenshot
      XDG_CURRENT_DESKTOP = "COSMIC";
    };
    systemPackages = with pkgs; [
      # COSMIC applets and Flatpak store
      unstable.cosmic-store

      # Other Wayland clipboard stuff
      wl-clipboard
      cliphist
    ];
  };

  systemd.services.cosmic-flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo
    '';
  };
  # Fix shutdown timing out for COSMIC sessions
  # systemd.user.services."cosmic-session".serviceConfig = {
  #   TimeoutStopSec = "10s";
  #   KillSignal = "SIGKILL";
  # };

  # Enable Seahorse for keyring management
  programs.seahorse.enable = true;
}

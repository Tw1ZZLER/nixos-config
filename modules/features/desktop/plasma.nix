# Enable KDE Plasma desktop environment
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6.enable = true;

    # # Portal configuration for screen sharing, file dialogs, etc.
    # # system-level portal is needed for secrets
    # xdg.portal = {
    #   enable = true;
    #   extraPortals = with pkgs; [
    #     kdePackages.xdg-desktop-portal-kde
    #   ];
    #   config = let
    #     common = {
    #       default = [
    #         "gnome"
    #         "gtk"
    #       ];
    #       "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
    #     };
    #   in {
    #     inherit common;
    #     niri = common;
    #   };
    #   configPackages = [pkgs.niri];
    # };

    environment = {
      variables = {
        # Xwayland-satellite
        # DISPLAY = ":0";
        # Wayland support for Electron and Chromium
        NIXOS_OZONE_WL = "1";
        # Fix icon theming
        # QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      systemPackages =
        (with pkgs; [
          # Other Wayland clipboard stuff
          wl-clipboard
          cliphist

          # Xwayland support
          xwayland-satellite
          xdg-utils
          qt6.qtwayland
          wayland
        ])
        ++ [
          # Force-blur for translucent apps (e.g. Ghostty on Plasma 6.7)
          inputs.kwin-effects-better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
  };

  # Plasma-manager configuration
  flake.homeModules.plasma = {...}: {
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
      # ./rc2nix.nix # Imported directly from the rc2nix dump
    ];

    programs.plasma = {
      enable = true;
      kwin.effects.blur.enable = false; # conflicts with Better Blur DX
      configFile."kwinrc" = {
        Plugins = {
          blurEnabled = false;
          better_blur_dxEnabled = true;
        };
        "Effect-better-blur-dx" = {
          WindowClasses = ''
            ghostty
            vesktop
          '';
          BlurMatching = true;
          BlurNonMatching = false;
          # Default strength is 14
          BlurStrength = 7;
          # Blur KWin titlebar / window chrome as well as client area
          BlurDecorations = true;
        };
      };
    };
  };
}

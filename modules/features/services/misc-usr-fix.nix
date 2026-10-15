# Fixes for non-Nix applications
# credit: https://wiki.nixos.org/wiki/Fixes_for_non-Nix_applications#Flatpak,_Distrobox,_Appimage_and_other_non-Nix_applications_can't_find_system_fonts/icons/themes
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.misc-usr-fix = {pkgs, ...}: let
    # Mount options for the bind mounts
    mountOptions = [
      "ro"
      "x-gvfs-hide"
      # Resolves symlinks as if they were real files
      # Needed for things like OnlyOffice
      "resolve-symlinks"
    ];
  in {
    # Bind mounts fonts, icons and themes from
    # The /run/current-system/sw/share/* paths
    # to their /usr/share/* equivalents

    # Expose all fonts
    # under /run/current-system/sw/share/X11/fonts
    fonts.fontDir.enable = true;

    # Flatpak: Bind mounts /usr/share/* directories
    system.fsPackages = [pkgs.bindfs];

    fileSystems = {
      # Fonts
      "/usr/share/fonts" = {
        device = "/run/current-system/sw/share/X11/fonts";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };

      # Icons
      "/usr/share/icons" = {
        device = "/run/current-system/sw/share/icons";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };

      # Themes
      "/usr/share/themes" = {
        device = "/run/current-system/sw/share/themes";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };
    };
  };
}

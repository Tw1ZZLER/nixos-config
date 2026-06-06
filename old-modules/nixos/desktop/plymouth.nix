# How to achieve slow but awesome boots
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    plymouth.enable = lib.mkEnableOption "Enable Plymouth for a graphical boot experience";
  };
  config = lib.mkIf config.plymouth.enable {
    # Plymouth / silent boot
    boot = {
      plymouth = {
        enable = true;
        # theme = "rings";
        # logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
        # themePackages = with pkgs; [
        #   # By default we would install all themes
        #   (adi1090x-plymouth-themes.override {
        #     selected_themes = [ "rings" ];
        #   })
        # ];
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      initrd.systemd.enable = true;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;
    };
  };
}

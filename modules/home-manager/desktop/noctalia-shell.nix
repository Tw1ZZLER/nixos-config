{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  # import the home manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options = {
    noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell integration.";
  };
  config = lib.mkIf config.noctalia-shell.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          position = "top";
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              { id = "Workspace"; }
              { id = "ActiveWindow"; }
              { id = "MediaMini"; }
            ];
            center = [
              {
                id = "Clock";
                formatHorizontal = "h:mm AP";
              }
              {
                id = "Clock";
                formatHorizontal = "yyyy-MM-dd";
              }
              {
                id = "SystemMonitor";
                showDiskUsage = true;
              }
            ];
            right = [
              { id = "NotificationHistory"; }
              { id = "Tray"; }
              { id = "Volume"; }
              { id = "Bluetooth"; }
              { id = "NightLight"; }
              { id = "Brightness"; }
              {
                id = "Battery";
                displayMode = "alwaysshow";
                warningThreshold = 15;
              }
              { id = "WiFi"; }
              { id = "SessionMenu"; }
            ];
          };
        };
        general = {
          avatarImage = "/home/tw1zzler/.face";
        };
        location = {
          useFahrenheit = true;
          use12hourFormat = true;
          monthBeforeDay = true;
          name = "Columbus, OH";
        };
        wallpaper = {
          directory = "/home/tw1zzler/media/img/wallpapers";
        };
        appLauncher = {
          enableClipboardHistory = true;
        };
        templates = {
          hyprland = true;
        };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  };
}

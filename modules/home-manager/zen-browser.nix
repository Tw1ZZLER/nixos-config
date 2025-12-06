# The best browser in the world right now
{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    # inputs.zen-browser.homeModules.beta
    inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  ];
  # Zen-browser as default browser
  xdg.mimeApps =
    let
      value =
        let
          zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta; # or twilight
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

  # Zen Browser Program
  programs.zen-browser = {
    enable = true;

    # POLICIES
    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );
      in
      {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true; # save webs for later reading
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
        };
      };

    # PROFILE
    profiles."tw1zzler" = {
      # Extensions
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        better-canvas
        bitwarden
        decentraleyes
        duckduckgo-privacy-essentials
        web-clipper-obsidian
        return-youtube-dislikes
        sponsorblock
        stylus
        ublock-origin
        violentmonkey
        zotero-connector
      ];

      # Container Tabs
      containersForce = true;
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "orange";
          icon = "briefcase";
          id = 2;
        };
        Banking = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
        College = {
          color = "turquoise";
          icon = "tree";
          id = 4;
        };
      };

      # Spaces
      spacesForce = true;
      spaces =
        let
          inherit (config.programs.zen-browser.profiles."tw1zzler") containers;
        in
        {
          "College" = {
            id = "00c706b6-4239-4915-ac6d-f93ec2cdd749";
            icon = "💽";
            container = containers."College".id;
            position = 1000;
          };
          "Research" = {
            id = "{f04cb5c2-d9e1-473f-b91d-e7b1277c7961}";
            icon = "🔏";
            container = containers."Work".id;
            position = 2000;
          };
          "Robotics" = {
            id = "4deb6ee3-5d78-4ceb-a7d8-7f4d9d30b22e";
            icon = "🔧";
            container = containers."College".id;
            position = 3000;
          };
          "ACM" = {
            id = "5d6a2f3a-d301-400f-aadc-9a391567d3ee";
            icon = "💻";
            container = containers."College".id;
            position = 4000;
          };
          "Leisure" = {
            id = "8f7f9ec5-e9d4-464c-b41b-82078057b4e8";
            icon = "🧊"; # get it, cuz chilling
            container = containers."Personal".id;
            position = 5000;
          };
          "Music" = {
            id = "{1b1efd97-f8e8-42f7-926e-3dc4867d66fc}";
            icon = "🎼";
            container = containers."Personal".id;
            position = 6000;
          };
        };
    };
  };
}

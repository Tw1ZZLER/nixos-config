{
  self,
  inputs,
  ...
}: {
  flake.homeModules.discord = {...}: {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    programs.nixcord = {
      enable = true;
      discord = {
        vencord.enable = true;
      };
      vesktop.enable = true;
      # Midnight transparency toggles + translucent nord panels (compositor blur shows through)
      quickCss = ''
        body {
          --transparency-tweaks: on;
          --remove-bg-layer: on;
          --panel-blur: off;
        }
        :root {
          --bg-3: hsla(220, 16%, 18%, 0.65);
          --bg-4: hsla(220, 16%, 22%, 0.7);
        }
      '';
      config = {
        frameless = true;
        # Vesktop true window transparency (Vencord transparent → Electron transparent + #00000000)
        transparent = true;
        useQuickCss = true;
        themeLinks = [
          "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-nord.theme.css"
        ];
        enabledThemeLinks = [
          "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-nord.theme.css"
        ];
        plugins = {
          alwaysTrust.enable = true;
          # anammox.enable = true;
          clearUrls.enable = true;
          fakeNitro.enable = true;
          fixYoutubeEmbeds.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          # friendshipRanks.enable = true;
          fullSearchContext.enable = true;
          # gitHubRepos.enable = true;
          # globalBadges.enable = true;
          # ignoreTerms.enable = true;
          implicitRelationships.enable = true;
          # inviteDefaults.enable = true;
          # jumpTo.enable = true;
          loadingQuotes.enable = true;
          noDevtoolsWarning.enable = true;
          noF1.enable = true;
          # noNitroUpsell.enable = true;
          openInApp.enable = true;
          # questify.enable = true;
          # steamStatusSync.enable = true;
          # UserPFP.enable = true;
          usrbg.enable = true;
          viewIcons.enable = true;
          youtubeAdblock.enable = true;
        };
      };
      extraConfig = {
        # Some extra JSON config here
      };
    };
  };
}

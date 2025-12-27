{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  options = {
    discord.enable = lib.mkEnableOption "Enable Discord (Nixcord) configuration";
  };

  config = lib.mkIf config.discord.enable {

    programs.nixcord = {
      enable = true;
      discord = {
        vencord.enable = false;
        equicord.enable = true;
      };
      vesktop.enable = false;
      equibop.enable = true;
      config = {
        frameless = true;
        plugins = {
          alwaysTrust.enable = true;
          anammox.enable = true;
          ClearURLs.enable = true;
          fakeNitro.enable = true;
          fixYoutubeEmbeds.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          friendshipRanks.enable = true;
          fullSearchContext.enable = true;
          gitHubRepos.enable = true;
          globalBadges.enable = true;
          ignoreTerms.enable = true;
          implicitRelationships.enable = true;
          inviteDefaults.enable = true;
          jumpTo.enable = true;
          loadingQuotes.enable = true;
          noDevtoolsWarning.enable = true;
          noF1.enable = true;
          noNitroUpsell.enable = true;
          openInApp.enable = true;
          questify.enable = true;
          steamStatusSync.enable = true;
          UserPFP.enable = true;
          USRBG.enable = true;
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

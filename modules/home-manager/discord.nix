# (Proprietary) Communication platform
{ pkgs, ... }:
{
  # ...
  programs.nixcord = {
    enable = true; # Enable Nixcord (It also installs Discord)
    discord = {
      vencord.enable = false; # Use Vencord (default)
      equicord.enable = true; # Or use Equicord instead (cannot enable both)
    };
    vesktop.enable = false; # Vesktop
    equibop.enable = true; # Equibop
    config = {
      frameless = true; # Set some Vencord/Equicord options
      plugins = {
        alwaysTrust.enable = true;
        anammox.enable = true;
        clearUrLs.enable = true;
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
        userPfp.enable = true;
        usrbg.enable = true;
        viewIcons.enable = true;
        youtubeAdblock.enable = true;
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
  # ...
}

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
        questify.enable = true;
        betterFolders.enable = true;
        anammox.enable = true;
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
  # ...
}

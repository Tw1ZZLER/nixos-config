# I like these user directories better because they are easy to type (and match more closely to the rest of the Linux filesystem)
{ config, ... }:
{
  xdg = {
    # Enable XDG
    enable = true;

    # Adjust XDG user directories
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/dl";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media/img";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/template";
      videos = "${config.home.homeDirectory}/media/vid";
      createDirectories = true;
    };
  };
}

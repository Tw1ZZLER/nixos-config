{ pkgs }:
{
  # It's better to use unstable for this sort of thing
  environment.systemPackages = with pkgs.unstable; [
    # Wine
    wineWowPackages.staging
    winetricks
    wineasio # JACK to ASIO driver
  ];
}

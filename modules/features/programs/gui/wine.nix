# Enable Wine for running Windows applications
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.wine = {pkgs, ...}: {
    # It's better to use unstable for this sort of thing
    environment.systemPackages = with pkgs; [
      # Wine
      wineWow64Packages.staging
      winetricks
      wineasio # JACK to ASIO driver
      # (bottles.override { removeWarningPopup = true; }) # GUI for managing Wine prefixes
    ];
  };
}

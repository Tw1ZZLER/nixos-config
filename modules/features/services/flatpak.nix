# Enable Flatpak package manager
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.flatpak = {pkgs, ...}: {
    # Need flatpak for some packages
    services.flatpak.enable = true;
    systemd.services.add-flathub = {
      description = "Add Flathub Flatpak repository";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
        RemainAfterExit = true;
      };
    };
  };
}

# Enable Flatpak package manager
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.flatpak = {pkgs, ...}: {
    imports = [self.nixosModules.misc-usr-fix];
    services.flatpak.enable = true;
    systemd.services.add-flathub = {
      description = "Add Flathub Flatpak repository";
      wantedBy = ["sysinit-reactivation.target"];
      before = ["sysinit-reactivation.target"];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.flatpak}/bin/flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
        RemainAfterExit = true;
      };
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    flatpak.enable = lib.mkEnableOption "Enable Flatpak package manager";
  };
  config = lib.mkIf config.flatpak.enable {
    # Need flatpak for some packages (particularly COSMIC DE)
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

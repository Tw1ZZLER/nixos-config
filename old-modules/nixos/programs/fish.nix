# https://nixos.wiki/wiki/Fish
# Vendor completions provided by Nixpkgs require this module to be enabled.
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fish.enable = lib.mkEnableOption "Enable fish vendor completions provided by Nixpkgs";
  };
  config = lib.mkIf config.fish.enable {
    programs.fish.enable = true;
    environment.systemPackages = with pkgs.unstable; [ grc ];
  };
}

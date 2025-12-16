{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
  };

  home.sessionVariables = {
    NH_FLAKE = "/home/tw1zzler/nixos-config";
  };

  home.packages = with pkgs.unstable; [
    nix-output-monitor
    nvd
  ];
}

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    nix-helper.enable = lib.mkEnableOption "Enable Nix helper tools";
  };

  config = lib.mkIf config.nix-helper.enable {
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
  };
}

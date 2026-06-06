{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nix-helper = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      package = pkgs.nh;
    };

    home.sessionVariables = {
      NH_FLAKE = "/home/tw1zzler/nixos-config";
    };

    home.packages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };
}

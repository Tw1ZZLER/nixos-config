{
  self,
  inputs,
  ...
}: {
  flake.homeModules.nix-helper = {...}: {
    programs.nh = {
      enable = true;
      flake = "/home/tw1zzler/nixos-config";
      osFlake = "/home/tw1zzler/nixos-config";
      homeFlake = "/home/tw1zzler/nixos-config";
      darwinFlake = "/home/tw1zzler/nixos-config";
      clean = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}

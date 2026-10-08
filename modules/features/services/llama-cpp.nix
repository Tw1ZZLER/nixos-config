# llama.cpp inference engine
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.llama-cpp = {pkgs, ...}: {
    environment.systemPackages = [pkgs.llama-cpp-rocm];
    services.llama-cpp = {
      enable = true;
      openFirewall = true;

      # my machine is AMD device
      package = pkgs.llama-cpp-rocm;
      settings = {
        models-dir = "/home/tw1zzler/FASTDATA/models";
        host = "127.0.0.1";
        port = 8080;
        no-models-autoload = true;
        spec-draft-n-max = 3;
        spec-type = "draft-mtp";
      };
    };
  };
}

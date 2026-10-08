# llama.cpp inference engine
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.llama-cpp = {pkgs, ...}: let
    # Host path. /home/tw1zzler is mode 0700, and the unit sets ProtectHome=true,
    # so llama-server cannot open this path itself (Permission denied).
    modelsDir = "/home/tw1zzler/FASTDATA/models";
  in {
    environment.systemPackages = [pkgs.llama-cpp-rocm];
    services.llama-cpp = {
      enable = true;
      openFirewall = true;

      # my machine is AMD device
      package = pkgs.llama-cpp-rocm;
      settings = {
        # Visible inside the service after the bind below.
        models-dir = "/var/lib/llama-cpp/models";
        host = "127.0.0.1";
        port = 9931;
        no-models-autoload = true;
        spec-draft-n-max = 3;
        spec-type = "draft-mtp";
        ctx-size = 16384;
        batch-size = 2048;
        gpu-layers = 99;
        threads = 8;

        # KV cache quantization
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";

        flash-attn = "on";
      };
    };

    # PID 1 bind-mounts this as root, before ProtectHome and DynamicUser apply.
    systemd.services.llama-cpp.serviceConfig.BindReadOnlyPaths = [
      "${modelsDir}:/var/lib/llama-cpp/models"
    ];
  };
}

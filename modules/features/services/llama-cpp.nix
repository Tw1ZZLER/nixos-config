# llama.cpp inference engine
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.llama-cpp = {pkgs, ...}: {
    # my machine is AMD device
    environment.systemPackages = [pkgs.llama-cpp-rocm];
  };
}

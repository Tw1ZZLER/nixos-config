{ lib, config, ... }:
{
  options = {
    docker.enable = lib.mkEnableOption "Enable Docker containerization platform";
  };
  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      # Add any additional Docker configuration options here
    };
  };
}

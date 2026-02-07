# Xilinx tooling, including Vivado and Vitis
# Uses overlay made available by MIT OpenCompute's nix-xilinx flake
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    xilinx.enable = lib.mkEnableOption "Enable Xilinx tooling, including Vivado and Vitis";
  };

  config = lib.mkIf config.xilinx.enable {
    home.packages = with pkgs; [
      xilinx-shell
      vivado # WARN: Proprietary
      vitis # WARN: Proprietary
      vitis_hls # WARN: Proprietary
      model_composer # WARN: Proprietary
    ];
  };
}

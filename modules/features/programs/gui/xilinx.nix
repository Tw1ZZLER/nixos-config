# Xilinx tooling, including Vivado and Vitis
# Uses overlay made available by MIT OpenCompute's nix-xilinx flake
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.xilinx = {
    nixpkgs.overlays = [inputs.nix-xilinx.overlay];
  };

  flake.homeModules.xilinx = {pkgs, ...}: {
    home.packages = with pkgs; [
      xilinx-shell
      vivado # WARN: Proprietary
      vitis # WARN: Proprietary
      vitis_hls # WARN: Proprietary
      model_composer # WARN: Proprietary
    ];
  };
}

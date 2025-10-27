{ pkgs, ... }:
{
  # Graphics stuffs
  # (https://wiki.nixos.org/wiki/Intel_Graphics)
  # https://nixos.org/manual/nixos/stable/#sec-gpu-accel
  hardware.graphics = {
    enable = true; # Enable OpenGL (graphics)
    extraPackages = with pkgs; [
      vpl-gpu-rt # Intel Quick Sync Video (QSV)
      intel-compute-runtime # OpenCL
      intel-ocl # Official proprietary OpenCL library # WARN: Proprietary
      intel-media-driver # (VAAPI) Enable hardware acceleration with the Intel iHD driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}

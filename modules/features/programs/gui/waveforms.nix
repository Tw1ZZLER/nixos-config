# https://github.com/DragonHuntrX/waveforms-flake-local
# Absolute gigachad uploaded the .deb files directly to GitHub
# Enable Digilent Waveforms
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.waveforms = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.waveforms.overlay];
    services.udev.packages = [pkgs.adept2-runtime];
    environment.systemPackages = [pkgs.waveforms];
    users.users.tw1zzler.extraGroups = ["plugdev" "dialout"];
    users.groups.plugdev = {};
    services.udev.extraRules = ''
      # Digilent Vendor ID
      SUBSYSTEM=="usb", ATTR{idVendor}=="1443", MODE="0666", TAG+="uaccess"

      # Digilent devices using FTDI chips (like Analog Discovery 2)
      SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6014", MODE="0666", TAG+="uaccess"
    '';

    # The Linux kernel automatically grabs FTDI chips using its built-in
    # ftdi_sio serial driver. When the kernel claims the device as a standard
    # serial port (/dev/ttyUSB*), libdept / WaveForms cannot access it over
    # the USB bus layer. You must blacklist ftdi_sio so the userspace Digilent
    # runtime can talk to the FTDI chip raw.
    boot.blacklistedKernelModules = ["ftdi_sio"];
  };
}

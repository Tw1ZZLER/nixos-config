# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    # ./hardware-configuration.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules

    # Or modules from other flakes
    inputs.home-manager.nixosModules.home-manager

    # Hardware specific configuration, see section below for a more complete
    # list of modules
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.display-vc4

    # Disko configuration (ZFS)
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  # ZFS support
  networking.hostId = "8821e310";

  # Raspberry Pi specific configuration
  hardware.raspberry-pi.config = {
    all = {
      # [all] conditional filter, https://www.raspberrypi.com/documentation/computers/config_txt.html#conditional-filters

      options = {
        # https://www.raspberrypi.com/documentation/computers/config_txt.html#enable_uart
        # in conjunction with `console=serial0,115200` in kernel command line (`cmdline.txt`)
        # creates a serial console, accessible using GPIOs 14 and 15 (pins
        #  8 and 10 on the 40-pin header)
        enable_uart = {
          enable = true;
          value = true;
        };
        # https://www.raspberrypi.com/documentation/computers/config_txt.html#uart_2ndstage
        # enable debug logging to the UART, also automatically enables
        # UART logging in `start.elf`
        uart_2ndstage = {
          enable = true;
          value = true;
        };
      };

      # Base DTB parameters
      # https://github.com/raspberrypi/linux/blob/a1d3defcca200077e1e382fe049ca613d16efd2b/arch/arm/boot/dts/overlays/README#L132
      base-dt-params = {

        # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#enable-pcie
        pciex1 = {
          enable = true;
          value = "on";
        };
        # PCIe Gen 3.0
        # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#pcie-gen-3-0
        pciex1_gen = {
          enable = true;
          value = "3";
        };

      };

    };
  };

  # Server configuration module for running server
  server-networking.enable = true;

  # Optional: Binary cache for the flake
  nix.settings = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This is identical to what nixos installer does in
  # (modulesPash + "profiles/installation-device.nix")

  # Use less privileged nixos user
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  # Allow the user to log in as root without a password.
  users.users.root.initialHashedPassword = "";

  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit.enable = true;

  # Allow passwordless sudo from nixos user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "nixos";

  # We run sshd by default. Login is only possible after adding a
  # password via "passwd" or by adding a ssh key to ~/.ssh/authorized_keys.
  # The latter one is particular useful if keys are manually added to
  # installation device for head-less systems i.e. arm boards by manually
  # mounting the storage in a different system.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # allow nix-copy to live system
  nix.settings.trusted-users = [ "nixos" ];

  # We are stateless, so just default to latest.
  system.stateVersion = config.system.nixos.release;

  # This is mostly portions of safe network configuration defaults that
  # nixos-images and srvos provide

  networking.useNetworkd = true;
  # mdns
  networking.firewall.allowedUDPPorts = [ 5353 ];
  systemd.network.networks = {
    "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
    "99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";
  };

  # This comment was lifted from `srvos`
  # Do not take down the network for too long when upgrading,
  # This also prevents failures of services that are restarted instead of stopped.
  # It will use `systemctl restart` rather than stopping it with `systemctl stop`
  # followed by a delayed `systemctl start`.
  systemd.services = {
    systemd-networkd.stopIfChanged = false;
    # Services that are only restarted might be not able to resolve when resolved is stopped before
    systemd-resolved.stopIfChanged = false;
  };

  # Use iwd instead of wpa_supplicant. It has a user friendly CLI
  networking.wireless.enable = false;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings.AutoConnect = true;
    };
  };

  time.timeZone = "UTC";
  networking.hostName = "rpi${config.boot.loader.raspberryPi.variant}-demo";

  services.udev.extraRules = ''
    # Ignore partitions with "Required Partition" GPT partition attribute
    # On our RPis this is firmware (/boot/firmware) partition
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';

  environment.systemPackages = with pkgs; [
    tree
  ];

  users.users.nixos.openssh.authorizedKeys.keys = [
    # YOUR SSH PUB KEY HERE #

  ];
  users.users.root.openssh.authorizedKeys.keys = [
    # YOUR SSH PUB KEY HERE #

  ];

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberryPi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "MALENIA";
  networking.networkmanager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}

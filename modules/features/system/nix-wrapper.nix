# Now this is Meta (Configuring Nix with Nix in Nix)
# Enable opinionated Nix configuration wrapper
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nix-wrapper = {...}: {
    nix = {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";

        # Extra Binary Caches
        extra-substituters = [
          "https://install.determinate.systems" # determinate nix
          "https://nix-community.cachix.org" # disko, nixos-anywhere, etc
          "https://hercules-ci.cachix.org" # flake-parts
          "https://noctalia.cachix.org" # noctalia
          "https://catppuccin.cachix.org" # catppuccin
          "https://nixos-raspberrypi.cachix.org" # nixos-raspberrypi
        ];
        extra-trusted-public-keys = [
          "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hercules-ci.cachix.org-1:g99HiMR8Y9Z8mYicrKWW04daP0W5ZshhZ/pYgNfC+1U="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "catppuccin.cachix.org-1:noGdz9JST3clb8h9W9q6CZvGsDY6HG0cmM6b856w06M="
          "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
        trusted-users = ["root" "tw1zzler" "@wheel"];

        # optional, useful when the builder has a faster internet connection than yours
        builders-use-substitutes = true;
      };
      extraOptions = ''
        warn-dirty = false
      '';
      # add to extraOptions later when this secret is added
      # !include ${config.sops.secrets.nixAccessTokens.path}

      # Disable channels
      channel.enable = false;

      # You can see the resulting builder-strings of this NixOS-configuration with "cat /etc/nix/machines".
      # These builder-strings are used by the Nix terminal tool, e.g.
      # when calling "nix build ...".
      buildMachines = [
        # {
        #   # Will be used to call "ssh builder" to connect to the builder machine.
        #   # The details of the connection (user, port, url etc.)
        #   # are taken from your "~/.ssh/config" file.
        #   hostName = "MALENIA";
        #   # CPU architecture of the builder, and the operating system it runs.
        #   # Replace the line by the architecture of your builder, e.g.
        #   # - Normal Intel/AMD CPUs use "x86_64-linux"
        #   # - Raspberry Pi 4 and 5 use  "aarch64-linux"
        #   # - M1, M2, M3 ARM Macs use   "aarch64-darwin"
        #   # - Newer RISCV computers use "riscv64-linux"
        #   # See https://github.com/NixOS/nixpkgs/blob/nixos-unstable/lib/systems/flake-systems.nix
        #   # If your builder supports multiple architectures
        #   # (e.g. search for "binfmt" for emulation),
        #   # you can list them all, e.g. replace with
        #   # systems = ["x86_64-linux" "aarch64-linux" "riscv64-linux"];
        #   system = "aarch64-linux";
        #   # Nix custom ssh-variant that avoids lots of "trusted-users" settings pain
        #   protocol = "ssh-ng";
        #   # default is 1 but may keep the builder idle in between builds
        #   maxJobs = 4;
        #   supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        #   sshUser = "nixremote";
        #   sshKey = "/root/.ssh/id_ed25519"; # Path to the local root user's private key
        # }
      ];
      # required, otherwise remote buildMachines above aren't used
      distributedBuilds = true;
    };
  };
}

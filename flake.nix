{
  description = "Tw1ZZLER's Nix Configuration";

  #  $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$\  $$\   $$\ $$$$$$$$\  $$$$$$\
  # $$  __$$\ $$ |  $$ |\__$$  __|$$  __$$\ $$ |  $$ |\__$$  __|$$  __$$\
  # $$ /  $$ |$$ |  $$ |   $$ |   $$ |  $$ |$$ |  $$ |   $$ |   $$ /  \__|
  # $$ |  $$ |$$ |  $$ |   $$ |   $$$$$$$  |$$ |  $$ |   $$ |   \$$$$$$\
  # $$ |  $$ |$$ |  $$ |   $$ |   $$  ____/ $$ |  $$ |   $$ |    \____$$\
  # $$ |  $$ |$$ |  $$ |   $$ |   $$ |      $$ |  $$ |   $$ |   $$\   $$ |
  #  $$$$$$  |\$$$$$$  |   $$ |   $$ |      \$$$$$$  |   $$ |   \$$$$$$  |
  #  \______/  \______/    \__|   \__|       \______/    \__|    \______/

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);

  # $$$$$$\ $$\   $$\ $$$$$$$\  $$\   $$\ $$$$$$$$\  $$$$$$\
  # \_$$  _|$$$\  $$ |$$  __$$\ $$ |  $$ |\__$$  __|$$  __$$\
  #   $$ |  $$$$\ $$ |$$ |  $$ |$$ |  $$ |   $$ |   $$ /  \__|
  #   $$ |  $$ $$\$$ |$$$$$$$  |$$ |  $$ |   $$ |   \$$$$$$\
  #   $$ |  $$ \$$$$ |$$  ____/ $$ |  $$ |   $$ |    \____$$\
  #   $$ |  $$ |\$$$ |$$ |      $$ |  $$ |   $$ |   $$\   $$ |
  # $$$$$$\ $$ | \$$ |$$ |      \$$$$$$  |   $$ |   \$$$$$$  |
  # \______|\__|  \__|\__|       \______/    \__|    \______/

  inputs = {
    #
    # ========= Official NixOS, Darwin, and HM Package Sources =========
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Dendritic Libraries =========
    #
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    #
    # ========= Utilities =========
    #
    # Utility wrappers
    # wrappers = {
    #   url = "github:BirdeeHub/nix-wrapper-modules";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Mainly here for `follows` optimization
    # https://nixos.wiki/wiki/Flakes#Using_flakes_project_from_a_legacy_Nix
    flake-compat.url = "github:NixOS/flake-compat";

    # Nix Index
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko - NixOS installation utility
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management with SOPS-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Anywhere
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        disko.follows = "disko";
      };
    };

    # Garuda Linux Nix Subsystem
    garuda = {
      url = "gitlab:garuda-linux/garuda-nix-subsystem/stable";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        nix-index-database.follows = "nix-index-database";
        home-manager.follows = "home-manager";
      };
    };

    # NixOS Raspberry Pi configurations
    # follow `main` branch of this repository, considered being stable
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.flake-compat.follows = "flake-compat";
    };

    # Determinate Systems
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Applications =========
    #
    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # Firefox Add-ons from NUR
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Xilinx / Vivado Flake
    nix-xilinx = {
      url = "github:MIT-OpenCompute/xilinx-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    # Digilent Waveforms Flake
    waveforms = {
      url = "github:DragonHuntrX/waveforms-flake-local";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord - Discord client management for home-manager
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };

    # Twintail Launcher
    twintail-launcher = {
      url = "github:Tw1ZZLER/twintail-launcher-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pano Scrobbler
    pano-scrobbler = {
      url = "github:kawaiiDango/pano-scrobbler-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # REAPER DAW flake
    reaper-flake = {
      url = "github:9Prestidigitator/reaper-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    #
    # ========= Ricing =========
    #
    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    #
    # ========= Personal Repositories =========
    #
    # My Neovim Configuration
    vimridian = {
      url = "github:tw1zzler/vimridian";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@codeberg.org/Tw1ZZLER/nix-secrets.git?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

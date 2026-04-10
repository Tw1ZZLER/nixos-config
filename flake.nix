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

  outputs =
    {
      self,
      nixpkgs,
      garuda,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      # namespace = "tw1zzler"; # namespace for custom modules

      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = lib.genAttrs systems;

    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # Formatter for your nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeModules = import ./modules/home-manager;

      # Development shell for NixOS configuration
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nil # lsp language server for nix
              nixpkgs-fmt
              sops
              inputs.nixos-anywhere.packages.${system}.default
            ];
          };
        }
      );

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        PRIMUS = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./hosts/PRIMUS/configuration.nix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs outputs; };
                users.tw1zzler.imports = [
                  ./hosts/PRIMUS/home.nix
                ];
              };
            }
          ];
        };
        REDMOND = garuda.lib.garudaSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main Garuda Linux Nix Subsystem configuration file <
            ./hosts/REDMOND/configuration.nix
          ];
        };
        MALENIA = inputs.nixos-raspberrypi.lib.nixosSystemFull {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos-raspberrypi configuration file <
            ./hosts/MALENIA/configuration.nix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs outputs; };
                users.tw1zzler.imports = [
                  ./hosts/MALENIA/home.nix
                ];
              };
            }
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "tw1zzler@REDMOND" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main home-manager configuration file <
            ./hosts/REDMOND/home.nix
          ];
        };
      };
    };

  # $$$$$$\ $$\   $$\ $$$$$$$\  $$\   $$\ $$$$$$$$\  $$$$$$\
  # \_$$  _|$$$\  $$ |$$  __$$\ $$ |  $$ |\__$$  __|$$  __$$\
  #   $$ |  $$$$\ $$ |$$ |  $$ |$$ |  $$ |   $$ |   $$ /  \__|
  #   $$ |  $$ $$\$$ |$$$$$$$  |$$ |  $$ |   $$ |   \$$$$$$\
  #   $$ |  $$ \$$$$ |$$  ____/ $$ |  $$ |   $$ |    \____$$\
  #   $$ |  $$ |\$$$ |$$ |      $$ |  $$ |   $$ |   $$\   $$ |
  # $$$$$$\ $$ | \$$ |$$ |      \$$$$$$  |   $$ |   \$$$$$$  |
  # \______|\__|  \__|\__|       \______/    \__|    \______/

  inputs = {
    # Enable flake support for Git submodules
    self.submodules = true;

    #
    # ========= Official NixOS, Darwin, and HM Package Sources =========
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # The next two are for pinning to stable vs unstable regardless of what the above is set to
    # This is particularly useful when an upcoming stable release is in beta because you can effectively
    # keep 'nixpkgs-stable' set to stable for critical packages while setting 'nixpkgs' to the beta branch to
    # get a jump start on deprecation changes.
    # See also 'stable-packages' and 'unstable-packages' overlays at 'overlays/default.nix"
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========= Utilities =========
    #
    # Utility wrappers
    # wrappers = {
    #   url = "github:BirdeeHub/nix-wrapper-modules";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Mainly here for `follows` optimization
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

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

    # Firefox Add-ons from NUR
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Anywhere
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        disko.follows = "disko";
      };
    };

    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
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

    # NixGL
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Raspberry Pi configurations
    # follow `main` branch of this repository, considered being stable
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.flake-compat.follows = "flake-compat";
    };

    # Minimal Neovim Wrapper
    mnw.url = "github:Gerg-L/mnw";

    # Trying out LazyVim Flake
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

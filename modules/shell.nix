# Development shell for NixOS configuration
{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      # If rbw is available and unlocked, dynamically export the token into memory
      shellHook = ''
        if command -v rbw &> /dev/null && rbw unlocked &> /dev/null; then
          export GITHUB_TOKEN="$(rbw get 'GitHub PAT for Nix CLI')"
        fi
      '';

      nativeBuildInputs = with pkgs; [
        nixd # Nix LSP
        statix # Nix linter
        alejandra # Nix formatter
        rbw # Bitwarden CLI
        tack # Inputs / pins manager
        inputs.nixos-anywhere.packages.${pkgs.stdenv.hostPlatform.system}.default # Install NixOS anywhere
      ];
    };
  };
}

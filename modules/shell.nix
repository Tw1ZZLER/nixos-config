# Development shell for NixOS configuration
{inputs, ...}: {
  flake.perSystem.devShells = {pkgs, ...}: {
    default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nixd # Nix LSP
        statix # Nix linter
        alejandra # Nix formatter
        sops # Secrets management
        inputs.nixos-anywhere.packages.${pkgs.stdenv.hostPlatform.system}.default # Install NixOS anywhere
      ];
    };
  };
}

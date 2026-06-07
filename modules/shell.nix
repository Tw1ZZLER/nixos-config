#  Development shell for NixOS configuration
{
  self,
  inputs,
  ...
}: {
  flake.perSystem.devShells = {pkgs, ...}: {
    default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nixd # Nix LSP
        statix # Nix linter
        alejandra # Nix formatter
        sops # Secrets management
        inputs.nixos-anywhere.packages.${system}.default # Install NixOS anywhere
      ];
    };
  };
}

{
  description = "Tw1ZZLER's Nix Configuration";

  # Inputs are handled by Tack in the .tack/ directory
  # Outputs are handled by flake-parts in the modules/ directory

  outputs = {self, nixpkgs ? null, ...}: let
    inputs = (import ./.tack) // {inherit self;};
  in
    inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);
}

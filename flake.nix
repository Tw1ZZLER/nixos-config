{
  description = "Tw1ZZLER's Nix Configuration";

  # Inputs are handled by Tack in the .tack/ directory
  # Outputs are handled by flake-parts in the modules/ directory

  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {overrides = args.tackOverrides or {};};
  in
    inputs.flake-parts.lib.mkFlake
    {inherit inputs self;}
    (inputs.import-tree ./modules);
}

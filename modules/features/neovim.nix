{
  self,
  inputs,
  ...
}: {
  flake.homeModules.neovim =
    # Vimridian is named after the Between the Buried and Me song, Viridian
    # It is a beautiful song with a bass solo and is the precursor to one of the
    # greatest songs of all time (imo), White Walls
    {pkgs, ...}: let
      system = pkgs.stdenv.hostPlatform.system;
      vimridian = inputs.vimridian.packages.${system}.maximal;
    in {
      home = {
        shellAliases.vimdiff = "nvim -d";
        shellAliases.nvim-dev = "${vimridian.dev}/bin/nvim";
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
        packages = [
          vimridian.default
        ];
      };
    };
}

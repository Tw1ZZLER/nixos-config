# Vimridian is named after the Between the Buried and Me song, Viridian
# It is a beautiful song with a bass solo and is the precursor to one of the
# greatest songs of all time (imo), White Walls
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    neovim.enable = lib.mkEnableOption "Enable my Neovim configuration, Vimridian";
  };

  config = lib.mkIf config.neovim.enable {
    home = {
      shellAliases.vimdiff = "nvim -d";
      shellAliases.nvim-dev = "${
        inputs.vimridian.packages.${pkgs.stdenv.hostPlatform.system}.maximal.dev
      }/bin/nvim";
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      packages = [
        inputs.vimridian.packages.${pkgs.stdenv.hostPlatform.system}.maximal.default

      ];
    };
  };
}

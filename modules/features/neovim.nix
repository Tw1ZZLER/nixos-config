{
  self,
  inputs,
  ...
}: {
  flake.homeModules.neovim =
    # Vimridian is named after the Between the Buried and Me song, Viridian
    # It is a beautiful song with a bass solo and is the precursor to one of the
    # greatest songs of all time (imo), White Walls
    {
      pkgs,
      lib,
      config,
      inputs,
      ...
    }: {
      options = {
        neovim.enable = lib.mkEnableOption "Enable my Neovim configuration, Vimridian";
      };

      config = lib.mkIf config.neovim.enable {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          vimdiffAlias = true;

          # Vimridian package
          package = inputs.vimridian.packages.${pkgs.stdenv.hostPlatform.system}.maximal.default;
        };

        # nvim-dev alias
        home.shellAliases.nvim-dev = "${
          inputs.vimridian.packages.${pkgs.stdenv.hostPlatform.system}.maximal.dev
        }/bin/nvim";
      };
    };
}

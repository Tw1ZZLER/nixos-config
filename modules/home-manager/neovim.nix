# The best text editor
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = with pkgs.unstable; [
      # Idk why LazyVim needs this but it does
      unzip

      # Nix Formatter
      nixfmt-rfc-style

      # Required by Snacks.image
      imagemagick
    ];
    extraLuaPackages =
      luaPkgs: with pkgs.unstable.lua51Packages; [
        luautf8
      ];
    extraPython3Packages =
      pyPkgs: with pkgs.unstable.python312Packages; [
        pynvim
        pylatexenc
      ];
  };
  xdg.configFile."nvim".source = ../../dotfiles/nvim;
}

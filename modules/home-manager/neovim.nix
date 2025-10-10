{ pkgs }:
{

  #  Neovim
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [ unzip ];
    # extraLuaPackages = luaPkgs: with luaPkgs; [ luautf8 ];
    # extraPython3Packages = pyPkgs: with pyPkgs; [ pynvim ];
  };
}

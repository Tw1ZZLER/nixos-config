{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    fish.enable = lib.mkEnableOption "Enable fish shell configuration";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      package = pkgs.unstable.fish;
      interactiveShellInit = builtins.readFile ../../../../dotfiles/fish/config.fish;
    };

    home.packages = with pkgs.unstable.fishPlugins; [
      bass
      autopair
      grc
    ];

    xdg.configFile."fish/completions".source = ../../../../dotfiles/fish/completions;

    programs.eza = {
      enable = true;
      package = pkgs.unstable.eza;
    };

    programs.bat = {
      enable = true;
      package = pkgs.unstable.bat;
    };

    programs.fd = {
      enable = true;
      package = pkgs.unstable.fd;
    };

    programs.ripgrep = {
      enable = true;
      package = pkgs.unstable.ripgrep;
    };

    programs.fzf = {
      enable = true;
      package = pkgs.unstable.fzf;
    };

    programs.btop = {
      enable = true;
      package = pkgs.unstable.btop;
    };

    programs.fastfetch = {
      enable = true;
      package = pkgs.unstable.fastfetch;
    };

    programs.yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
    };

    programs.nix-index.enable = true;
  };
}

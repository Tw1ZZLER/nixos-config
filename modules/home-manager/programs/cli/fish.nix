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
  };
}

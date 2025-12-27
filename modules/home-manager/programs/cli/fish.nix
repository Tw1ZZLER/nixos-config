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

      functions = {
        runsilk = {
          body = ''
            cd /home/tw1zzler/Silk
            python -m server &
            cd /home/tw1zzler/Silk/GUI
            python -m http.server 8000 &
          '';
        };
      };

    };

    home.packages = with pkgs.unstable.fishPlugins; [
      bass
      autopair
      grc
    ];

    xdg.configFile."fish/completions".source = ../../../../dotfiles/fish/completions;
  };
}

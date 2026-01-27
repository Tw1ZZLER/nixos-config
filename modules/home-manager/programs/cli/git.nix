{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    git.enable = lib.mkEnableOption "Enable git and related tools";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Corbin";
          email = "63320116+Tw1ZZLER@users.noreply.github.com";
        };
      };
    };

    programs.lazygit = {
      enable = true;
      package = pkgs.unstable.lazygit;
    };

    home.packages = with pkgs.unstable; [
      gh # GitHub CLI
      codeberg-cli # gh-like tool for Codeberg
    ];
  };
}

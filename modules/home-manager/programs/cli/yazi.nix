{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    yazi.enable = lib.mkEnableOption "Enable yazi, a modern terminal file manager";
  };

  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      shellWrapperName = "y";

      plugins = with pkgs.unstable.yaziPlugins; {
        inherit
          chmod
          diff
          full-border
          git
          lazygit
          mount
          smart-enter
          ;
      };

      keymap = {
        mgr.prepend_keymap = [
          {
            run = "plugin chmod";
            on = [
              "c"
              "m"
            ];
            desc = "Chmod on selected files";
          }
          {
            run = "plugin mount";
            on = "M";
            desc = "Mount plugin";
          }
          {
            run = "plugin smart-enter";
            on = "l";
            desc = "Enter the child directory, or open the file";
          }
          {
            run = "plugin diff";
            on = "<C-d>";
            desc = "Diff the selected with the hovered file";
          }
          {
            run = "plugin lazygit";
            on = [
              "g"
              "g"
            ];
            desc = "Open lazygit in the current directory";
          }
        ];

      };

      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
      '';

      settings = {
        plugin.prepend_fetchers = [
          {
            id = "git";
            name = "*"; # use `url` if you're using the nightly version of Yazi
            run = "git";
          }
          {
            id = "git";
            name = "*/"; # use `url` if you're using the nightly version of Yazi
            run = "git";
          }
        ];
      };

      # flavors = [ ];
      # theme = [ ];
    };
  };
}

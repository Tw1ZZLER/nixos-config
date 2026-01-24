{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fastfetch.enable = lib.mkEnableOption "Enable fastfetch, a fast and highly customizable system information tool";
  };

  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      package = pkgs.unstable.fastfetch;
      settings = {
        logo = {
          type = "builtin";
          height = 1;
          width = 1;
          padding = {
            top = 3;
            left = 1;
          };
        };
        modules = [
          "break"
          {
            type = "custom";
            format = "┌──────────────────────Hardware──────────────────────┐";
          }
          {
            type = "host";
            key = " PC";
            keyColor = "green";
          }
          {
            type = "cpu";
            key = "│ ├";
            keyColor = "green";
          }
          {
            type = "gpu";
            key = "│ ├󰍛";
            keyColor = "green";
          }
          {
            type = "memory";
            key = "│ ├󰍛";
            keyColor = "green";
          }
          {
            type = "disk";
            key = "└ └";
            keyColor = "green";
          }
          {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
          }
          "break"
          {
            type = "custom";
            format = "┌──────────────────────Software──────────────────────┐";
          }
          {
            type = "os";
            key = " OS";
            keyColor = "yellow";
          }
          {
            type = "kernel";
            key = "│ ├";
            keyColor = "yellow";
          }
          {
            type = "bios";
            key = "│ ├";
            keyColor = "yellow";
          }
          {
            type = "packages";
            key = "│ ├󰏖";
            keyColor = "yellow";
          }
          {
            type = "shell";
            key = "└ └";
            keyColor = "yellow";
          }
          {
            type = "de";
            key = " DE";
            keyColor = "blue";
          }
          {
            type = "lm";
            key = "│ ├";
            keyColor = "blue";
          }
          {
            type = "wm";
            key = "│ ├";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = "│ ├󰉼";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = "└ └";
            keyColor = "blue";
          }
          {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
          }
          "break"
          {
            type = "custom";
            format = "┌────────────────────Uptime / Age / DT────────────────────┐";
          }
          {
            type = "command";
            key = "  OS Age ";
            keyColor = "magenta";
            text = ''
              birth_install=$(stat -c %W /);
              current=$(date +%s);
              time_progression=$((current - birth_install));
              days_difference=$((time_progression / 86400));
              echo $days_difference days
            '';
          }
          {
            type = "uptime";
            key = "  Uptime ";
            keyColor = "magenta";
          }
          {
            type = "datetime";
            key = "  DateTime ";
            keyColor = "magenta";
          }
          {
            type = "custom";
            format = "└─────────────────────────────────────────────────────────┘";
          }
          {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";
          }
        ];
      };
    };
  };
}

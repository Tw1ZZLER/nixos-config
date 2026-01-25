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
    home.sessionVariables = {
      SHELL = "${pkgs.unstable.fish}/bin/fish";

      # Use bat for man pages
      MANPAGER = "sh -c 'col -bx | ${pkgs.unstable.bat}/bin/bat -l man -p'";
      MANROFFOPT = "-c";
    };

    programs.fish = {
      enable = true;
      package = pkgs.unstable.fish;
      interactiveShellInit = builtins.readFile ../../../../dotfiles/fish/config.fish;
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "......" = "cd ../../../../../";
        "boot" = "nh os boot";
        "cls" = "clear";
        "diffnix" = "nvd diff $(sh -c 'ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2')";
        "edit" = "sops";
        "gcommit" = "git commit -m";
        "glcone" = "git clone";
        "gpr" = "git pull --rebase";
        "gpull" = "git pull";
        "gpush" = "git push";
        "reb" = "nh os switch";
        "roll" = "nh os switch -- --rollback";
        "run" = "comma ";
        "su" = "sudo su -";
        "tarnow" = "tar -acf ";
        "testb" = "nh os test";
        "tree" = "eza --git --color always -T";
        "untar" = "tar -zxvf ";
        "use" = "nix shell nixpkgs#";
      };
      shellAliases = {
        # Replace some more things with better alternatives
        "bat" = "bat --style header --style snip --style changes";
        "cat" = "bat --style header --style snip --style changes";
        "dd" = "dd progress=status";
        "diffnix" = "nvd diff $(sh -c 'ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2')";
        "dir" = "dir --color=auto";
        "grep" = "rg";
        "egrep" = "egrep --color=auto";
        "fastfetch" = "fastfetch -l nixos";
        "fgrep" = "fgrep --color=auto";
        "gitlog" = "git log --oneline --graph --decorate --all";
        "ip" = "ip --color=auto";
        "psmem" = "ps auxf | sort -nr -k 4";
        "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
        "vdir" = "vdir --color=auto";
        "wget " = "wget -c";
        "hw" = "hwinfo --short"; # Hardware Info

        # Get the error messages from journalctl
        "jctl" = "journalctl -p 3 -xb";

        # Replace ls with eza
        "ls" = "eza -al --color=always --group-directories-first --icons";
        "lsz" = "eza -al --color=always --total-size --group-directories-first --icons"; # include file size
        "la" = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
        "ll" = "eza -l --color=always --group-directories-first --icons"; # long format
        "lt" = "eza -aT --color=always --group-directories-first --icons"; # tree listing
        "l." = "eza -ald --color=always --group-directories-first --icons .*"; # show only dotfiles
      };

      # Hide welcome message & ensure we are reporting fish as shell
      shellInit = ''
        set fish_greeting
        set VIRTUAL_ENV_DISABLE_PROMPT 1
      '';

      functions = {
        runsilk = ''
          cd /home/tw1zzler/Silk
          python -m server &
          cd /home/tw1zzler/Silk/GUI
          python -m http.server 8000 &
        '';

        # Copy DIR1 DIR2
        copy = ''
          set count (count $argv | tr -d \n)
          if test "$count" = 2; and test -d "$argv[1]"
              set from (echo $argv[1] | string trim --right --chars=/)
              set to (echo $argv[2])
              command cp -r $from $to
          else
              command cp $argv
          end
        '';

        # Fish command history
        history = ''
          builtin history --show-time='%F %T '
        '';

        # function backup --argument filename
        #     cp $filename $filename.bak
        # end

        # Backup a file
        backup = {
          body = ''
            cp $filename $filename.bak
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

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bash.enable = lib.mkEnableOption "Enable bash shell configuration";
  };

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      # Execute fish in case we aren't using a login shell
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.unstable.fish}/bin/fish $LOGIN_OPTION
        fi
      '';

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "......" = "cd ../../../../../";
        "bat" = "bat --style header --style snip --style changes";
        "boot" = "nh os boot";
        "cat" = "bat --style header --style snip --style changes";
        "cls" = "clear";
        "dd" = "dd progress=status";
        "diffnix" = "nvd diff $(sh -c 'ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2')";
        "dir" = "dir --color=auto";
        "edit" = "sops";
        "egrep" = "egrep --color=auto";
        "fgrep" = "fgrep --color=auto";
        "gcommit" = "git commit -m";
        "gitlog" = "git log --oneline --graph --decorate --all";
        "glcone" = "git clone";
        "gpr" = "git pull --rebase";
        "gpull" = "git pull";
        "gpush" = "git push";
        "hw" = "hwinfo --short"; # Hardware Info
        "ip" = "ip --color=auto";
        "jctl" = "journalctl -p 3 -xb";
        "l." = "eza -ald --color=always --group-directories-first --icons .*"; # show only dotfiles
        "la" = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
        "ll" = "eza -l --color=always --group-directories-first --icons"; # long format
        "ls" = "eza -al --color=always --group-directories-first --icons";
        "lsz" = "eza -al --color=always --total-size --group-directories-first --icons"; # include file size
        "lt" = "eza -aT --color=always --group-directories-first --icons"; # tree listing
        "psmem" = "ps auxf | sort -nr -k 4";
        "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
        "reb" = "nh os switch";
        "roll" = "nh os switch -- --rollback";
        "su" = "sudo su -";
        "tarnow" = "tar -acf ";
        "testb" = "nh os test";
        "tree" = "eza --git --color always -T";
        "untar" = "tar -zxvf ";
        "use" = "nix shell nixpkgs#";
        "vdir" = "vdir --color=auto";
        "wget" = "wget -c";
      };
    };
  };
}

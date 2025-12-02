{ pkgs, ... }:
{
  # Fish
  programs.fish = {
    enable = true;
    package = pkgs.unstable.fish;

    # Main fish config (exec at shell start)
    interactiveShellInit = builtins.readFile ../../dotfiles/fish/config.fish;

    # Extra conf.d files
    # shellInit = ''
    #   for file in ${../../dotfiles/fish/conf.d}/*.fish
    #       source $file
    #   end
    # '';

    # Inline shell aliases (you can remove if using conf.d/aliases.fish)
    # shellAliases = {
    #   ll = "ls -al";
    #   gs = "git status";
    # };

    # Import custom functions
    # functions = {
    #
    # };
  };

  # Fish plugins
  home.packages = with pkgs.unstable.fishPlugins; [
    bass
    autopair
    grc
  ];

  # Fish dotfiles
  xdg.configFile."fish/completions".source = ../../dotfiles/fish/completions;
  xdg.configFile."fish/themes".source = ../../dotfiles/fish/themes;

  # Eza (replacement for ls)
  programs.eza = {
    enable = true;
    package = pkgs.unstable.eza;
  };

  # Bat (replacement for cat)
  programs.bat = {
    enable = true;
    package = pkgs.unstable.bat;
  };

  # Fd (replacement for find)
  programs.fd = {
    enable = true;
    package = pkgs.unstable.fd;
  };

  # Ripgrep (replacement for grep)
  programs.ripgrep = {
    enable = true;
    package = pkgs.unstable.ripgrep;
  };

  # Fzf (command line fuzzy finder)
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
  };

  # Btop (resource monitor)
  programs.btop = {
    enable = true;
    package = pkgs.unstable.btop;
  };

  # Fastfetch (system info)
  programs.fastfetch = {
    enable = true;
    package = pkgs.unstable.fastfetch;
  };

  # Yazi (terminal file explorer)
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
  };

  # Nix Index (for searching nix packages)
  programs.nix-index.enable = true;

}

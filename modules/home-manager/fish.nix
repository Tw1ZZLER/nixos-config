{ pkgs, ... }:
{
  # Fish
  programs.fish = {
    enable = true;
    package = pkgs.unstable.fish;
  };

  # Fish dotfiles
  xdg.configFile."fish".source = ../../dotfiles/fish;

  # Starship prompt
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
  };

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

  # Ugrep (will be replaced by ripgrep)
  home.packages = with pkgs.unstable; [
    ugrep
  ];

  # Nix Index (for searching nix packages)
  programs.nix-index.enable = true;

}

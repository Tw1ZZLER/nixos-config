{ pkgs, ... }:
{
  # Starship prompt
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    # settings = (builtins.fromTOML (builtins.readFile ../../dotfiles/starship.toml));
  };
}

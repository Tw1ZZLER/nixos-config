# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{
  # List your module files here
  # my-module = import ./my-module.nix;
  # DEFAULTS For all systems!
  imports = [
    ../nixpkgs.nix
    ./dotfiles.nix
    ./fonts.nix
    ./gaming.nix
    ./neovim.nix
    ./obsidian.nix
    ./onu.nix
    ./reaper.nix
    ./syncthing.nix
    ./vscode.nix
    ./wezterm.nix
    ./xdg-user-dirs.nix
    ./zen-browser.nix
  ];
}

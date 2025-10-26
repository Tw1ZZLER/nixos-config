# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
{
  # List your module files here
  # my-module = import ./my-module.nix;
  # DEFAULTS For all systems!
  imports = [
    ../nixpkgs.nix
    ./discord.nix
    ./dotfiles.nix
    ./exercism.nix
    ./fish.nix
    ./fonts.nix
    ./gaming.nix
    ./git.nix
    ./neovim.nix
    ./obs-studio.nix
    ./obsidian.nix
    ./onu.nix
    ./python.nix
    ./reaper.nix
    ./syncthing.nix
    ./thunderbird.nix
    ./torrent.nix
    ./vscode.nix
    ./wezterm.nix
    ./xdg-user-dirs.nix
    ./zen-browser.nix
  ];

  # I don't see this stuff ever changing
  home = {
    username = "tw1zzler";
    homeDirectory = "/home/tw1zzler";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

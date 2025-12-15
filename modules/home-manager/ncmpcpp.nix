{ pkgs, ... }:
{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.unstable.ncmpcpp;
  };
}

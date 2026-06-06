{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      config."config.kdl".content = ../../dotfiles/niri/config.kdl;
      # xdg.configFile."niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
    };
  };
}

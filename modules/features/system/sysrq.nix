# Re-enable Magic Alt + SysRq key
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sysrq = {...}: {
    boot.kernel.sysctl."kernel.sysrq" = 1;
  };
}

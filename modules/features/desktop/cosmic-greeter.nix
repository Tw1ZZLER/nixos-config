{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cosmic-greeter = {...}: {
    # Enable the COSMIC login manager
    services = {
      displayManager = {
        cosmic-greeter = {
          enable = true;
        };
        autoLogin = {
          enable = true;
          user = "tw1zzler";
        };
      };
    };
  };
}

# Enable the greetd display manager
{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.greetd = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # Tuigreet automatically passes the right session variables to niri-session
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };

    # Optional: Ensures tuigreet looks clean on a standard TTY
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}

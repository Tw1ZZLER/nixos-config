# rbw CLI for managing Bitwarden secrets; rbw-agent is the SSH agent
{
  self,
  inputs,
  ...
}: {
  flake.homeModules.rbw = {pkgs, ...}: {
    programs.rbw = {
      enable = true;
      settings = {
        email = inputs.nix-secrets.emails.personal;
        lock_timeout = 604800;
        pinentry = pkgs.pinentry-curses;
      };
    };

    home.sessionVariables = {
      # Point OpenSSH at rbw-agent — leave desktop SSH agent disabled in the UI
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";

      # Bitwarden API key for registering device
      # BW_CLIENTID = "${config.sops.secrets.bw-client-id}";
      # BW_CLIENTSECRET = "${config.sops.secrets.bw-client-secret}";
    };
  };
}

{ lib, outputs, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };
    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };
  users.users.caio.openssh.authorizedKeys.keyFiles = ../hosts/inspiron/ssh_host_ed25519_key.pub;

  programs.ssh = {
    # Each hosts public key
    knownHosts = lib.genAttrs (lib.attrNames outputs.nixosConfigurations) (
      hostname: {
        publicKeyFile = ../hosts/${hostname}/ssh_host_ed25519_key.pub;
      }
    );
  };

  # Keep SSH_AUTH_SOCK when sudo'ing
  security.sudo.extraConfig = ''
    Defaults env_keep+=SSH_AUTH_SOCK
  '';
}

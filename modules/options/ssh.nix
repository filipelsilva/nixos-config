{
  config,
  inputs,
  ...
}: {
  programs.ssh.startAgent = true;

  services = {
    openssh = {
      enable = true;
      settings = {
        passwordAuthentication = false;
        kbdInteractiveAuthentication = false;
        permitRootLogin = "no";
      };
      hostKeys = [
        {
          comment = "host key (rsa)";
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          comment = "host key (ed25519)";
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];
    };
  };
}

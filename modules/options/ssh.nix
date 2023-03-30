{
  config,
  inputs,
  ...
}: {
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
          comment = "host key";
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];
    };
  };
}

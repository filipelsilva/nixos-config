{config, ...}: {
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host * !server !nas
        SetEnv TERM=xterm-256color
    '';
  };

  services = {
    openssh = {
      enable = true;
      allowSFTP = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
      hostKeys = [
        {
          comment = "host_key_${config.networking.hostName}_rsa";
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          comment = "host_key_${config.networking.hostName}_ed25519";
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];
    };
  };
}

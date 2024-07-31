{...}: {
  programs.gnupg = {
    agent = {
      enableExtraSocket = true;
      enableBrowserSocket = true;
      enableSSHSupport = false;
      enable = true;
    };
  };
}

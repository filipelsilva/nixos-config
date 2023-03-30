{
  config,
  inputs,
  ...
}: {
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
    };
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true; # TODO deploy com true
      };
      # guest = {
      # 	enable = true;
      # 	x11 = true;
      # };
    };
  };
}

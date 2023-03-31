{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # docker-compose # TODO is this needed?
    virt-manager
    virtualbox
    vagrant
  ];

  programs.dconf.enable = true; # For virt-manager

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
        enableExtensionPack = true;
      };
      guest = { # TODO deploy uncommented
        enable = true;
        x11 = true;
      };
    };
  };
}

{
  config,
  pkgs,
  pkgs2211,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pkgs2211.vagrant
    virt-manager
  ];

  virtualisation = {
    virtualbox.host = {
      enable = true;
      package = pkgs2211.virtualbox;
      enableExtensionPack = true;
    };
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      enableNvidia = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    podman = {
      enable = true;
      enableNvidia = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Minimal configuration for NFS support with Vagrant.
  services.nfs.server.enable = true;

  # Add firewall exception for VirtualBox provider
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  # Add firewall exception for libvirt provider when using NFSv4
  networking.firewall.interfaces."virbr1" = {
    allowedTCPPorts = [2049];
    allowedUDPPorts = [2049];
  };
}

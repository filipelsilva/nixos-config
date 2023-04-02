{
  config,
  pkgs,
  headless ? true,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    wget
    aria
    lynx
    socat
    netcat-openbsd
    nmap
    tcpdump
    bind
    gping
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager = {
      enable = true;
      plugins = [] ++ lib.optional (!headless)
        pkgs.networkmanagerapplet
        pkgs.networkmanager-openvpn
      ;
    };
    wireless.enable = true;
  };

  programs = {
    traceroute.enable = true;
    nm-applet = {
      enable = !headless;
      indicator = false; # TODO check this
    };
  };

  services.aria2.enable = true;
}

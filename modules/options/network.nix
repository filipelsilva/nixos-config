{
  config,
  pkgs,
  lib,
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
    # networkmanagerapplet # TODO is this needed?
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager = {
      enable = true;
      plugins = with pkgs; [pkgs.networkmanager-openvpn];
    };
    wireless.enable = true;
  };

  programs = {
    traceroute.enable = true;
    nm-applet = {
      enable = !headless;
      indicator = false; # TODO check this
    };
    openvpn3.enable = true;
  };

  services = {
    aria2.enable = true;
    openvpn.servers = {
    };
  };
}

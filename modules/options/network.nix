{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
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
      whois
      openssl
    ]
    ++ lib.optional (!headless) pkgs.networkmanagerapplet;

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
      indicator = true;
    };
    openvpn3.enable = true;
  };

  services = {
    aria2.enable = true;
    openvpn.servers = {
    };
  };
}

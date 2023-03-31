{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    wget
    lynx
    socat
    netcat-openbsd
    nmap
    tcpdump
    bind
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager.enable = true;
  };

  services.aria2.enable = true;
  programs = {
    traceroute.enable = true;
    nm-applet = {
      enable = true;
      indicator = false; # TODO check this
    };
  };
}

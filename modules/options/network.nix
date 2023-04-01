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
    networkmanager.enable = true;
  };

  programs = {
    traceroute.enable = true;
    nm-applet = {
      enable = !headless;
      indicator = false; # TODO check this
    };
  };
}

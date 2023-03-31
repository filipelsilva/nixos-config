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

  services.aria2.enable = true;
  programs = {
    traceroute.enable = true;
    nm-applet = {
      enable = !headless;
      indicator = false; # TODO check this
    };
  };
}

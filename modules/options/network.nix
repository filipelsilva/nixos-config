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

  programs.traceroute.enable = true;
  services.aria2.enable = true;
}

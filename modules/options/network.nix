{
  pkgs,
  lib,
  headless ? false,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      curl
      wget
      socat
      netcat-openbsd
      nmap
      tcpdump
      bind
      whois
      openssl
      protonvpn-cli
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      wireshark
      protonvpn-gui
    ]);

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      extraCommands = ''
        iptables -A INPUT -p tcp -s localhost --dport 3389 -j ACCEPT
        iptables -A INPUT -p tcp --dport 3389 -j DROP
      '';
    };
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      plugins = with pkgs; [networkmanager-openvpn];
    };
  };

  programs = {
    traceroute.enable = true;
    nm-applet.enable = !headless;
    openvpn3.enable = true;
  };

  services = {
    resolved.enable = true;
    openvpn.servers = {};
  };
}

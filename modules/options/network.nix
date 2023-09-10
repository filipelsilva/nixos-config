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
      aria
      lynx
      socat
      netcat-openbsd
      nmap
      tcpdump
      bind
      gping
      apacheHttpd
      oha
      whois
      openssl
      protonvpn-cli
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      protonvpn-gui
    ]);

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
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
    aria2.enable = true;
    openvpn.servers = {
      tecnicoVPN = {
        config = builtins.readFile (pkgs.fetchurl {
          url = "https://suporte.dsi.tecnico.ulisboa.pt/sites/default/files/files/tecnico.ovpn";
          sha256 = "def4397b2ac1d8810a1c95d70c993790f5d16cdc06b11a5c37c8663e5ee28414";
        });
        autoStart = false;
      };
    };
  };
}

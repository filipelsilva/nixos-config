{
  config,
  pkgs,
  lib,
  headless,
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
      wol
      ethtool
      protonvpn-cli
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      wireshark
      protonvpn-gui
    ]);

  userConfig.extraGroups = lib.mkIf config.networking.networkmanager.enable ["networkmanager"];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      extraCommands = "";
    };
    networkmanager = {
      enable = !headless;
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

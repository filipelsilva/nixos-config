{ ... }:
{
  flake.modules.nixos.core_network =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (config.custom) headless;
    in
    {
      environment.systemPackages =
        with pkgs;
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
          ipcalc
        ]
        ++ lib.lists.optionals (!headless) (
          with pkgs;
          [
            wireshark
            proton-vpn
            networkmanagerapplet
          ]
        );

      users.users.${config.custom.user}.extraGroups = lib.mkIf config.networking.networkmanager.enable [
        "networkmanager"
      ];

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ ];
          allowedUDPPorts = [ ];
          extraCommands = "";
        };
        networkmanager = {
          enable = !headless;
          dns = "systemd-resolved";
          plugins = with pkgs; [ networkmanager-openvpn ];
        };
      };

      programs = {
        traceroute.enable = true;
        nm-applet.enable = !headless;
        openvpn3.enable = true;
      };

      services = {
        resolved.enable = true;
        openvpn.servers = { };
      };

      # Fix nixos-rebuild failing on Network Manager wait-online
      systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
      systemd.network.wait-online.enable = false;
      boot.initrd.systemd.network.wait-online.enable = false;
    };
}

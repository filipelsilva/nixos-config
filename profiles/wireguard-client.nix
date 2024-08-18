{
  config,
  pkgs,
  ...
}: let
  keysFolder = "${config.userConfig.home}/wireguard-keys";

  generateWGKeys = let
    wg = "${pkgs.wireguard-tools}/bin/wg";
  in
    pkgs.writeShellScript "generate-wg-keys" ''
      mkdir -p ${keysFolder}
      chown ${config.userConfig.name}:${config.userConfig.group} ${keysFolder}

      privateKey="${keysFolder}/private"
      publicKey="${keysFolder}/public"

      if [ ! -f "$privateKey" ]; then
        ${wg} genkey | tee "$privateKey" | ${wg} pubkey > "$publicKey"
        chmod 600 "$privateKey"
        chmod 644 "$publicKey"
        chown ${config.userConfig.name}:${config.userConfig.group} "$privateKey" "$publicKey"
      fi
    '';
in {
  system.activationScripts.generateWGKeys.text = "${generateWGKeys}";

  networking = {
    firewall.allowedUDPPorts = [51820];
    wireguard.interfaces = {
      wg0 = {
        ips = ["10.0.0.3/24"];
        listenPort = 51820;

        privateKeyFile = "${keysFolder}/private";

        peers = [
          {
            name = "N100";
            publicKey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
            allowedIPs = ["10.0.0.1/32"];
            endpoint = "pipinhohome.hopto.org:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  # networking.wg-quick.interfaces = {
  #   wg0 = {
  #     address = [ "10.0.0.3/24" ];
  #     # dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];
  #     privateKeyFile = "${keysFolder}/private";
  #
  #     peers = [
  #       {
  #         publicKey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
  #         allowedIPs = [ "10.100.0.1" ];
  #         endpoint = "pipinhohome.hopto.org:51820";
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };

  # environment.etc."NetworkManager/system-connections/wg0.nmconnection".text = ''
  #   [connection]
  #   id=wg0
  #   type=wireguard
  #   interface-name=wg0
  #   uuid=9fd35c2e-0302-4270-9e37-3186fb2fa899
  #
  #   [wireguard]
  #   listen-port=51820
  #   private-key=${builtins.readFile "${keysFolder}/private"}
  #   private-key-flags=0
  #
  #   [wireguard-peer.HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=]
  #   endpoint=pipinhohome.hopto.org:51820
  #   allowed-ips=10.0.0.1/32
  #
  #   [ipv4]
  #   address1=10.0.0.3/32
  #   method=manual
  # '';
  #
  # networking.firewall = {
  #   checkReversePath = "loose";
  #   logReversePathDrops = true;
  #   extraCommands = ''
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
  #   '';
  #   extraStopCommands = ''
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
  #   '';
  # };

  # networking.networkmanager.ensureProfiles.profiles = {
  #   wg0 = {
  #     connection = {
  #       id = "wg0";
  #       type = "wireguard";
  #     };
  #     Interface = {
  #       address = "10.100.0.3/32";
  #       privatekey = builtins.readFile "${keysFolder}/private";
  #     };
  #     Peer = {
  #       allowedips = "10.100.0.1";
  #       endpoint = "pipinhohome.hopto.org:51820";
  #       publickey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
  #     };
  #   };
  # };
}

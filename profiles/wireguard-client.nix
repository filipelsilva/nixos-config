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
          }
        ];
      };
    };
  };
}

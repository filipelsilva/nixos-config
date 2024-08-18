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
    nat = {
      enable = true;
      externalInterface = "enp2s0";
      internalInterfaces = ["wg0"];
    };
    firewall.allowedUDPPorts = [51820];
    wireguard.interfaces = {
      wg0 = {
        ips = ["10.0.0.1/24"];
        listenPort = 51820;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp2s0 -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp2s0 -j MASQUERADE
        '';
        privateKeyFile = "${keysFolder}/private";
        peers = [
          # {
          #   name = "Y540";
          #   publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIEq7vY6uC3fO/XRiu4H30I6wNBduHFfSmqWrguigrxap";
          #   allowedIPs = ["10.0.0.2/32"];
          # }
          {
            name = "T490";
            publicKey = "KsOJ59jkvpaRwNGHl5ccWJaP5pHKHlvdz18V451xRF4=";
            allowedIPs = ["10.0.0.3/32"];
          }
          {
            name = "iPad";
            publicKey = "SYd35k2DSJ7LTwl/5UIIUzQCfVZTvVntF+NtvD94K2M=";
            allowedIPs = ["10.0.0.4/32"];
          }
          {
            name = "pixel7a";
            publicKey = "ur16KiJ8BjKzLyrSzCqD3iWk26zcXXblkd1fxi6Onjg=";
            allowedIPs = ["10.0.0.5/32"];
          }
        ];
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.wireguard;

  subnet = "10.153.153"; #w153guard
  port = 51820;

  keysFolder = "${config.userConfig.home}/.wireguard-keys";
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
  options.modules.wireguard = {
    enable = mkEnableOption "wireguard";

    type = mkOption {
      type = types.enum ["client" "server"];
      example = "client";
      description = "The type of peer that will be configured.";
    };

    lastOctet = mkOption {
      type = types.ints.between 1 254;
      example = "6";
      description = "The last octet of the peer's IP address.";
    };

    externalInterface = mkOption {
      type = types.str;
      example = "enp2s0";
      default = "";
      description = "The interface to use for external communication.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.lastOctet != null;
        message = "The option `modules.services.wireguard.lastOctet` is required when `modules.services.wireguard.enable` is true.";
      }
      {
        assertion = if cfg.type == "server" then cfg.externalInterface != "" else cfg.externalInterface == "";
        message = "The option `modules.services.wireguard.externalInterface` is required when `modules.services.wireguard.type` is 'server', and should be set to '' when `modules.service.wireguard.type` is 'client'.";
      }
    ];

    system.activationScripts.generateWGKeys.text = "${generateWGKeys}";

    networking = {
      nat = {
        enable = cfg.type == "server";
        externalInterface = cfg.externalInterface;
        internalInterfaces = ["wg0"];
      };
      firewall.allowedUDPPorts = [port];
      wireguard.interfaces = {
        wg0 = {
          ips = ["${subnet}.${builtins.toString cfg.lastOctet}/24"];
          listenPort = port;
          postSetup =
            if cfg.type == "server"
            then ''
              ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${subnet}.0/24 -o ${cfg.externalInterface} -j MASQUERADE
            ''
            else "";
          postShutdown =
            if cfg.type == "server"
            then ''
              ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${subnet}.0/24 -o ${cfg.externalInterface} -j MASQUERADE
            ''
            else "";
          privateKeyFile = "${keysFolder}/private";
          peers =
            [
              {
                name = "N100";
                publicKey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
                allowedIPs = ["${subnet}.1/32"];
                endpoint = "pipinhohome.hopto.org:${builtins.toString port}";
              }
              {
                name = "Y540";
                publicKey = "3PO5QzeOrYKzhhdI5tewfIHyxQB+k9SQSm0x0PrcZm8=";
                allowedIPs = ["${subnet}.2/32"];
                endpoint = "ligeirosilva.hopto.org:${builtins.toString port}";
              }
            ]
            ++ lib.optional (cfg.type == "server") [
              {
                name = "T490";
                publicKey = "KsOJ59jkvpaRwNGHl5ccWJaP5pHKHlvdz18V451xRF4=";
                allowedIPs = ["${subnet}.3/32"];
              }
              {
                name = "iPad";
                publicKey = "SYd35k2DSJ7LTwl/5UIIUzQCfVZTvVntF+NtvD94K2M=";
                allowedIPs = ["${subnet}.4/32"];
              }
              {
                name = "pixel7a";
                publicKey = "ur16KiJ8BjKzLyrSzCqD3iWk26zcXXblkd1fxi6Onjg=";
                allowedIPs = ["${subnet}.5/32"];
              }
            ];
        };
      };
    };
  };
}

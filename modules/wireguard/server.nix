{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.wireguard-server;

  subnet = "10.0.0";
  port = 51820;

  keysFolder = "${config.userConfig.home}/.wireguard-keys";
in {
  imports = [./keys.nix];

  options.modules.wireguard-server = {
    enable = mkEnableOption "wireguard-server";

    lastOctet = mkOption {
      type = types.ints.between 1 254;
      example = "6";
      description = "The last octet of the server's IP address.";
    };

    externalInterface = mkOption {
      type = types.str;
      example = "enp2s0";
      description = "The interface to use for external communication.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.lastOctet != null;
        message = "The option `modules.services.wireguard-server.lastOctet` is required when `modules.services.wireguard-server` is true.";
      }
      {
        assertion = cfg.externalInterface != null;
        message = "The option `modules.services.wireguard-server.externalInterface` is required when `modules.services.wireguard-server` is true.";
      }
    ];

    networking = {
      nat = {
        enable = true;
        externalInterface = cfg.externalInterface;
        internalInterfaces = ["wg0"];
      };
      firewall.allowedUDPPorts = [port];
      wireguard.interfaces = {
        wg0 = {
          ips = ["${subnet}.${builtins.toString cfg.lastOctet}/24"];
          listenPort = port;
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${subnet}.0/24 -o ${cfg.externalInterface} -j MASQUERADE
          '';
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${subnet}.0/24 -o ${cfg.externalInterface} -j MASQUERADE
          '';
          privateKeyFile = "${keysFolder}/private";
          peers = [
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

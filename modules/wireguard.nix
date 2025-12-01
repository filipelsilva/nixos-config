{
  config,
  lib,
  pkgs,
  ...
} @ inputs: let
  inherit (lib) types mkEnableOption mkOption mkIf;

  cfg = config.modules.wireguard;
in {
  options.modules.wireguard = {
    enable = mkEnableOption "wireguard";

    type = mkOption {
      type = types.enum ["client" "server"];
      example = "client";
      description = "The type of peer that will be configured.";
    };

    subnet = mkOption {
      type = types.str;
      example = "10.0.0";
      default = "10.153.153"; #w153guard
      description = "The subnet to be used for the network.";
    };

    lastOctet = mkOption {
      type = types.ints.between 1 254;
      example = "6";
      description = "The last octet of the peer's IP address.";
    };

    port = mkOption {
      type = types.int;
      example = 51820;
      default = 51820;
      description = "The port for wireguard to use.";
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
        assertion = cfg.subnet != null;
        message = "The option `modules.services.wireguard.subnet` is required when `modules.services.wireguard.enable` is true.";
      }
      {
        assertion = cfg.lastOctet != null;
        message = "The option `modules.services.wireguard.lastOctet` is required when `modules.services.wireguard.enable` is true.";
      }
      {
        assertion = cfg.port != null;
        message = "The option `modules.services.wireguard.port` is required when `modules.services.wireguard.enable` is true.";
      }
      {
        assertion = cfg.type == "server" -> cfg.externalInterface != "";
        message = "The option `modules.services.wireguard.externalInterface` is required when `modules.services.wireguard.type` is 'server'.";
      }
      {
        assertion = cfg.type == "client" -> cfg.externalInterface == "";
        message = "The option `modules.services.wireguard.externalInterface` should be empty when `modules.services.wireguard.type` is 'client'.";
      }
    ];

    # To create keys:
    # umask 077
    # wg genkey > privatekey
    # wg pubkey < privatekey > publickey

    environment.systemPackages = [pkgs.wireguard-tools];

    age.secrets.wg-privatekey = {
      file = "${inputs.self.outPath}/secrets/wg-privatekey-${config.networking.hostName}.age";
      # for permission, see man systemd.netdev
      mode = "640";
      owner = "systemd-network";
      group = "systemd-network";
    };

    networking.firewall = {
      allowedUDPPorts = [cfg.port];
      checkReversePath = mkIf (cfg.type == "client") "loose";
    };

    networking.nat = mkIf (cfg.type == "server") {
      enable = true;
      enableIPv6 = true;
      externalInterface = cfg.externalInterface;
      internalInterfaces = ["wg0"];
    };

    networking.useNetworkd = true;

    systemd.network = {
      enable = true;

      networks."50-wg0" = {
        matchConfig.Name = "wg0";

        address = [
          "${cfg.subnet}.${builtins.toString cfg.lastOctet}/32"
        ];

        networkConfig = mkIf (cfg.type == "server") {
          # do not use IPMasquerade,
          # unnecessary, causes problems with host ipv6
          IPv4Forwarding = true;
          IPv6Forwarding = true;
        };
      };

      netdevs."50-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };

        wireguardConfig = {
          ListenPort = cfg.port;

          # Ensure file is readable by `systemd-network` user
          PrivateKeyFile = config.age.secrets.wg-privatekey.path;

          # Automatically create routes for AllowedIPs
          RouteTable = "main";

          # FirewallMark marks all packets send and received by wg0
          # with the number 42, which can be used to define policy rules on these packets.
          FirewallMark = 42;
        };

        wireguardPeers =
          [
            {
              # N100 - Server
              PublicKey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
              Endpoint = "pipinhohome.hopto.org:${builtins.toString cfg.port}";
              PersistentKeepalive = 25;
              AllowedIPs = ["${cfg.subnet}.1/32"];
            }
            {
              # Y540 - Server
              PublicKey = "3PO5QzeOrYKzhhdI5tewfIHyxQB+k9SQSm0x0PrcZm8=";
              Endpoint = "ligeirosilva.hopto.org:${builtins.toString cfg.port}";
              PersistentKeepalive = 25;
              AllowedIPs = ["${cfg.subnet}.2/32"];
            }
          ]
          ++ lib.lists.optionals (cfg.type == "server") [
            {
              # T490
              PublicKey = "KsOJ59jkvpaRwNGHl5ccWJaP5pHKHlvdz18V451xRF4=";
              AllowedIPs = ["${cfg.subnet}.3/32"];
            }
            {
              # iPad
              PublicKey = "SYd35k2DSJ7LTwl/5UIIUzQCfVZTvVntF+NtvD94K2M=";
              AllowedIPs = ["${cfg.subnet}.4/32"];
            }
            {
              # pixel7a
              PublicKey = "ur16KiJ8BjKzLyrSzCqD3iWk26zcXXblkd1fxi6Onjg=";
              AllowedIPs = ["${cfg.subnet}.5/32"];
            }
          ];
      };
    };
  };
}

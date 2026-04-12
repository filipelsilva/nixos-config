{ ... }:
{
  flake.modules.nixos.services_wireguard =
    {
      inputs,
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.modules.wireguard;
    in
    {
      options.modules.wireguard = {
        enable = lib.mkEnableOption "wireguard";

        type = lib.mkOption {
          type = lib.types.enum [
            "client"
            "server"
          ];
          example = "client";
          description = "The type of peer that will be configured.";
        };

        subnet = lib.mkOption {
          type = lib.types.str;
          example = "10.0.0";
          default = "10.153.153";
          description = "The subnet to be used for the network.";
        };

        lastOctet = lib.mkOption {
          type = lib.types.ints.between 1 254;
          example = "6";
          description = "The last octet of the peer's IP address.";
        };

        port = lib.mkOption {
          type = lib.types.int;
          example = 51820;
          default = 51820;
          description = "The port for wireguard to use.";
        };

        externalInterface = lib.mkOption {
          type = lib.types.str;
          example = "enp2s0";
          default = "";
          description = "The interface to use for external communication.";
        };
      };

      config = lib.mkIf cfg.enable {
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

        environment.systemPackages = [ pkgs.wireguard-tools ];

        age.secrets.wg-privatekey = {
          file = "${inputs.self.outPath}/secrets/wg-privatekey-${config.networking.hostName}.age";
          mode = "640";
          owner = "systemd-network";
          group = "systemd-network";
        };

        networking.firewall = {
          allowedUDPPorts = [ cfg.port ];
          checkReversePath = lib.mkIf (cfg.type == "client") "loose";
        };

        networking.nat = lib.mkIf (cfg.type == "server") {
          enable = true;
          enableIPv6 = true;
          externalInterface = cfg.externalInterface;
          internalInterfaces = [ "wg0" ];
        };

        networking.useNetworkd = true;

        systemd.network = {
          enable = true;

          networks."50-wg0" = {
            matchConfig.Name = "wg0";

            address = [
              "${cfg.subnet}.${builtins.toString cfg.lastOctet}/32"
            ];

            networkConfig = lib.mkIf (cfg.type == "server") {
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

              PrivateKeyFile = config.age.secrets.wg-privatekey.path;

              RouteTable = "main";

              FirewallMark = 42;
            };

            wireguardPeers =
              lib.lists.optionals (cfg.lastOctet != 1) [
                {
                  PublicKey = "HqdoDNKy6da1z6UyBrCt71U7ZgOPqCXuY966zVWFtjw=";
                  Endpoint = "pipinhohome.hopto.org:${builtins.toString cfg.port}";
                  PersistentKeepalive = 25;
                  AllowedIPs = [ "${cfg.subnet}.1/32" ];
                }
              ]
              ++ lib.lists.optionals (cfg.lastOctet != 2) [
                {
                  PublicKey = "3PO5QzeOrYKzhhdI5tewfIHyxQB+k9SQSm0x0PrcZm8=";
                  Endpoint = "ligeirosilva.hopto.org:${builtins.toString cfg.port}";
                  PersistentKeepalive = 25;
                  AllowedIPs = [ "${cfg.subnet}.0/24" ];
                }
              ]
              ++ lib.lists.optionals (cfg.type == "server") [
                {
                  PublicKey = "KsOJ59jkvpaRwNGHl5ccWJaP5pHKHlvdz18V451xRF4=";
                  AllowedIPs = [ "${cfg.subnet}.3/32" ];
                }
                {
                  PublicKey = "SYd35k2DSJ7LTwl/5UIIUzQCfVZTvVntF+NtvD94K2M=";
                  AllowedIPs = [ "${cfg.subnet}.4/32" ];
                }
                {
                  PublicKey = "ur16KiJ8BjKzLyrSzCqD3iWk26zcXXblkd1fxi6Onjg=";
                  AllowedIPs = [ "${cfg.subnet}.5/32" ];
                }
              ];
          };
        };
      };
    };
}

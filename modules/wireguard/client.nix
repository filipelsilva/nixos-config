{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.wireguard-client;

  subnet = "10.153.153"; #w153guard
  port = 51820;

  keysFolder = "${config.userConfig.home}/.wireguard-keys";
in {
  imports = [./keys.nix];

  options.modules.wireguard-client = {
    enable = mkEnableOption "wireguard-client";

    lastOctet = mkOption {
      type = types.ints.between 1 254;
      example = "6";
      description = "The last octet of the client's IP address.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.lastOctet != null;
        message = "The option `modules.services.wireguard-client.lastOctet` is required when `modules.services.wireguard-client` is true.";
      }
    ];

    networking = {
      firewall.allowedUDPPorts = [port];
      wireguard.interfaces = {
        wg0 = {
          ips = ["${subnet}.${builtins.toString cfg.lastOctet}/24"];
          listenPort = port;
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
          ];
        };
      };
    };
  };
}

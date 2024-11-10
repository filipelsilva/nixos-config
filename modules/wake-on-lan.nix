{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkEnableOption mkOption mkIf;

  cfg = config.modules.wake-on-lan;
in {
  options.modules.wake-on-lan = {
    enable = mkEnableOption "wake-on-lan";

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
        assertion = cfg.externalInterface != null;
        message = "The option `modules.services.wake-on-lan.externalInterface` is required when `modules.services.wake-on-lan.enable` is true.";
      }
    ];

    networking.interfaces.${cfg.externalInterface}.wakeOnLan.enable = true;

    # port forward UDP 9
    # get network adapter MAC address
    # from LAN: wol <mac_addr>
    # from outside: wol -p 9 -i <ip_addr> <mac_addr>
    systemd.services.wake-on-lan = {
      description = "Wake on Lan (WoL) service";
      wantedBy = ["default.target"];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -s ${cfg.externalInterface} wol g
      '';
    };
  };
}

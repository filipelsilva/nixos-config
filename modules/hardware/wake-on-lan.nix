{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    types
    mkEnableOption
    mkOption
    mkIf
    ;

  cfg = config.modules.wake-on-lan;
in
{
  flake.modules.nixos.hardware_wake-on-lan =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.modules.wake-on-lan;
    in
    {
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

        systemd.services.wakeonlan = {
          description = "Wake on Lan (WoL) service";
          wantedBy = [ "default.target" ];
          after = [ "network.target" ];
          serviceConfig = {
            Type = "simple";
            RemainAfterExit = "true";
            ExecStart = "${pkgs.ethtool}/bin/ethtool -s ${cfg.externalInterface} wol g";
          };
        };
      };
    };
}

{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkEnableOption mkOption mkIf;

  cfg = config.modules.file-server;
in {
  options.modules.file-server = {
    enable = mkEnableOption "file-server";

    path-prefix = mkOption {
      type = types.str;
      example = "/files";
      default = "/files";
      description = "The path-prefix to be used for dufs.";
    };

    port = mkOption {
      type = types.int;
      example = 5000;
      default = 5000;
      description = "The port for dufs to use.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.path-prefix != null;
        message = "The option `modules.services.file-server.path-prefix` is required when `modules.services.file-server.enable` is true.";
      }
      {
        assertion = cfg.port != null;
        message = "The option `modules.services.file-server.port` is required when `modules.services.file-server.enable` is true.";
      }
    ];

    environment.systemPackages = [pkgs.dufs];

    systemd.services.file-server = {
      description = "file server using dufs";
      wantedBy = ["default.target"];
      script = ''
        ${pkgs.dufs}/bin/dufs -A --path-prefix ${cfg.path-prefix} --port ${cfg.port}
      '';
    };
  };
}

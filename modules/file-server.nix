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

    security = {
      enable = mkEnableOption "file-server.security";

      username = mkOption {
        type = types.str;
        example = "admin";
        description = "The username to be set in the file server.";
      };

      passwordFile = mkOption {
        type = types.str;
        example = "admin";
        description = "The path to the file containg the password to be set in the file server.";
      };
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
      {
        assertion = cfg.security.enable -> cfg.security.username != null;
        message = "The option `modules.services.file-server.security.username` is required when `modules.services.file-server.security.enable` is true.";
      }
      {
        assertion = cfg.security.enable -> cfg.security.passwordFile != null;
        message = "The option `modules.services.file-server.security.passwordFile` is required when `modules.services.file-server.security.enable` is true.";
      }
    ];

    environment.systemPackages = [pkgs.dufs];

    systemd.services.file-server = {
      description = "file server using dufs";
      wantedBy = ["default.target"];
      script = ''
        ${lib.optionalString (cfg.security.enable) "PASSWORD=$(cat ${cfg.security.passwordFile})"}
        ${pkgs.dufs}/bin/dufs -A \
          --port ${builtins.toString cfg.port} \
          ${lib.optionalString (cfg.path-prefix != null) "--path-prefix ${cfg.path-prefix}"} \
          ${lib.optionalString (cfg.security.enable) "-a ${cfg.security.username}:$PASSWORD@/:rw"}
      '';
    };
  };
}

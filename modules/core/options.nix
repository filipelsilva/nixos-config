{ ... }:
{
  flake.modules.nixos.core_options =
    { config, lib, ... }:
    {
      options.custom = {
        headless = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        dataPool = lib.mkOption {
          type = lib.types.nullOr (lib.types.attrs);
          default = null;
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = "filipe";
        };
        userFullName = lib.mkOption {
          type = lib.types.str;
          default = "Filipe Ligeiro Silva";
        };
        domain = lib.mkOption {
          type = lib.types.str;
          default = "filipelsilva.net";
        };
        home = lib.mkOption {
          type = lib.types.str;
          default = "/home/${config.custom.user}";
        };
        dots = lib.mkOption {
          type = lib.types.str;
          default = "/home/${config.custom.user}/nixos-config";
        };
      };
    };
}

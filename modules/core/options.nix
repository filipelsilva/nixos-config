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
        users = lib.mkOption {
          type = lib.types.attrsOf lib.types.attrs;
          default = {
            filipe = { };
          };
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = lib.head (lib.attrNames config.custom.users);
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

{ ... }:
let
  usersDir = ../users;
  entries = builtins.readDir usersDir;
  files = builtins.filter (n: builtins.hasSuffix ".nix" n && !builtins.hasPrefix "_" n) (
    builtins.attrNames entries
  );
  defaultUsers = builtins.listToAttrs (
    map (n: {
      name = n;
      value = { };
    }) files
  );
in
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
          default = defaultUsers;
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

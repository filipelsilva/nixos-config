{ lib }:
{
  discoverModules =
    path:
    let
      entries = builtins.readDir path;
      files = lib.filterAttrs (n: t: t == "directory" && !lib.hasPrefix "_" n) entries;
    in
    lib.mapAttrs' (n: _: {
      name = n;
      value = path + "/${n}/default.nix";
    }) files;

  forAllUsers = users: specFn: lib.mkMerge (map (user: { ${user} = specFn user; }) users);
}

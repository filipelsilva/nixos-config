{ lib }:
{
  discoverModules =
    path:
    let
      entries = builtins.readDir path;
      files = lib.filterAttrs (
        n: t: t == "regular" && lib.hasSuffix ".nix" n && !lib.hasPrefix "_" n
      ) entries;
    in
    lib.mapAttrs' (n: _: {
      name = lib.removeSuffix ".nix" n;
      value = path + "/${n}";
    }) files;

  forAllUsers = users: specFn: lib.mkMerge (map (user: { ${user} = specFn user; }) users);
}

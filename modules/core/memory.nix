{ ... }:
{
  flake.modules.nixos.core_memory =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (config.custom) headless;
    in
    {
      environment.systemPackages =
        with pkgs;
        [
          gdu
          fdupes
          parted
        ]
        ++ lib.lists.optionals (!headless) (
          with pkgs;
          [
            gparted
          ]
        );
    };
}

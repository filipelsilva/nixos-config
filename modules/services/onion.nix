{ pkgs, lib, ... }:
{
  flake.modules.nixos.services_onion =
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
          tor
          onionshare
          carburetor
        ]
        ++ lib.lists.optionals (!headless) (
          with pkgs;
          [
            tor-browser
            onionshare-gui
            ricochet-refresh
          ]
        );
    };
}

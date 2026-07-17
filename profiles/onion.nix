{
  lib,
  pkgs,
  headless,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  environment.systemPackages =
    with pkgs;
    [
      tor
      onionshare
    ]
    ++ lib.lists.optionals isLinux (
      with pkgs;
      [
        carburetor
      ]
    )
    ++ lib.lists.optionals (isLinux && !headless) (
      with pkgs;
      [
        tor-browser
        onionshare-gui
        ricochet-refresh
      ]
    );
}

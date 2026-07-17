{
  pkgs,
  lib,
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
      gdu
      fdupes
    ]
    ++ lib.lists.optionals isLinux (
      with pkgs;
      [
        parted
      ]
    )
    ++ lib.lists.optionals (isLinux && !headless) (
      with pkgs;
      [
        gparted
      ]
    );
}

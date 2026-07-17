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
      exiftool
      imagemagick
      mediainfo
    ]
    ++ lib.lists.optionals (isLinux && !headless) (
      with pkgs;
      [
        gthumb
        guvcview # Camera
      ]
    );
}

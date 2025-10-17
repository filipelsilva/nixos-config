{
  pkgs,
  lib,
  headless,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      exiftool
      imagemagick
      mediainfo
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      gthumb
      guvcview # Camera
    ]);
}

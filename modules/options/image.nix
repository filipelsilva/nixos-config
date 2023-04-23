{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      exiftool
      imagemagick
      mediainfo
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      sxiv
      gthumb
      gimp
      krita
      inkscape
      maim # Screenshot utility
      guvcview # Camera
      gpick # Color picker
      mypaint # Drawing table
      tesseract # OCR
    ]);
}

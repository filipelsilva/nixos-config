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
      sxiv
      gthumb
      maim # Screenshot utility
      guvcview # Camera
    ]);

  homeConfig = {config, ...}: {
    home.file = {
      ".config/sxiv" = {
        enable = !headless;
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/sxiv/.config/sxiv";
      };
    };
  };
}

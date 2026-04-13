{ ... }:
{
  flake.modules.nixos.programs_image =
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
          exiftool
          imagemagick
          mediainfo
        ]
        ++ lib.lists.optionals (!headless) (
          with pkgs;
          [
            gthumb
            guvcview # Camera
          ]
        );
    };
}

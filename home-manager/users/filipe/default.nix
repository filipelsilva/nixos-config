{
  lib,
  headless ? false,
  ...
}: {
  imports =
    [
      ../../options/darkman.nix
      ./headless.nix
    ]
    ++ lib.lists.optionals (!headless) [
      ../../options/xdg.nix
      ./graphical.nix
    ];
}

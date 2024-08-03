{
  lib,
  headless,
  ...
}: {
  imports =
    [
      ./headless.nix
    ]
    ++ lib.lists.optionals (!headless) [
      ./graphical.nix
    ];
}

{
  lib,
  headless ? false,
  ...
}: {
  imports =
    [
      ../../options/home.nix
      ../../options/zsh.nix
      ./headless.nix
    ]
    ++ lib.lists.optionals (!headless) [
      ../../options/xdg.nix
      ./graphical.nix
    ];
}

{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  imports =
    [
      ../../options/home.nix
      ../../options/zsh.nix
      ./headless.nix
    ]
    ++ lib.lists.optionals (!headless) [
      ../../options/bluetooth.nix
      ../../options/xdg.nix
      ./graphical.nix
    ];
}
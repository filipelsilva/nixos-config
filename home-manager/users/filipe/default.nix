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
    ++ lib.optional (!headless) ./xdg.nix ./graphical.nix;
}

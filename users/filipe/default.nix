{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  imports = [./headless.nix] ++ lib.optional (!headless) ./graphical.nix;
}

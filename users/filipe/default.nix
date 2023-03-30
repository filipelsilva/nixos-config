{headless ? true}: {
  imports = [./headless.nix] ++ lib.optional (!headless) ./graphical.nix;
}

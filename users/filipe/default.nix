{
  lib,
  headless ? false,
}: {
  imports = [./headless.nix] ++ lib.optional (!headless) ./graphical.nix;
}

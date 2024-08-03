{
  lib,
  headless,
  ...
}: {
  imports = [./headless.nix] ++ lib.optional (!headless) ./graphical.nix;
}

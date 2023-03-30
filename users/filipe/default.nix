{headless ? true}: {
  imports = [./home-headless.nix] ++ lib.optional (!headless);
}

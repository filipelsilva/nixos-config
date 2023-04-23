{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      transmission
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      transmission-gtk
    ]);
}

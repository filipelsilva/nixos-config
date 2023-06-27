{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
  services.transmission.enable = true;
  environment.systemPackages = lib.lists.optionals (!headless) (with pkgs; [
    transmission-gtk
  ]);
}

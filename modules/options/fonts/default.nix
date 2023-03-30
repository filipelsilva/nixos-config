{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./headless.nix
    ./graphical.nix
  ];
}

{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./i3.nix
    ./mouse.nix
    ./packages.nix
  ];
}

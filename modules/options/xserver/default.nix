{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./i3.nix
    ./libinput.nix
    ./mouse.nix
    ./packages.nix
  ];
}

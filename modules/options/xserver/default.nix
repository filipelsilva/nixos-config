{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./autorandr.nix
    ./i3.nix
    ./libinput.nix
    ./packages.nix
  ];
}

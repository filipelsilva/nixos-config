{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = pkgs.system == "x86_64-linux";
    };
  };
  imports = [
    ./steam.nix
  ];
}

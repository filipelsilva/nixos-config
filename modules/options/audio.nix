{
  config,
  pkgs,
  inputs,
  ...
}: {
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  nixpkgs.config.pulseaudio = true;
}

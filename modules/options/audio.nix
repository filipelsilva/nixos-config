{
  config,
  inputs,
  ...
}: {
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  nixpkgs.config.pulseaudio = true;
}

{ ... }:
{
  flake.modules.nixos.desktop_audio =
    { ... }:
    {
      userConfig.extraGroups = [ "audio" ];

      security.rtkit.enable = true;

      services = {
        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          audio.enable = true;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          jack.enable = true;
          wireplumber.enable = true;
        };
      };
    };
}

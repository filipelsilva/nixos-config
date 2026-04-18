{ lib, ... }:
let
  forAllUsers = (import ../lib/_lib.nix { inherit lib; }).forAllUsers;
in
{
  flake.modules.nixos.desktop_audio =
    { config, lib, ... }:
    {
      users.users = forAllUsers (lib.attrNames config.custom.users) (user: {
        extraGroups = [ "audio" ];
      });

      security.rtkit.enable = true;

      services = {
        pulseaudio.enable = false; # Ensure PulseAudio is disabled
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

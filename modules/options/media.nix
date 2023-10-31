{
  pkgs,
  lib,
  headless ? false,
  ...
}: {
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  nixpkgs.config.pulseaudio = true;

  services.transmission.enable = true;

  environment.systemPackages = with pkgs;
    [
      yt-dlp
      flac
      sox
      ffmpeg
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      vlc
      mpv
      clementine
      handbrake
      kid3
      playerctl
      obs-studio
      spotify
      streamlink
      pavucontrol
      spek
      transmission-gtk
    ]);
}

{
  config,
  pkgs,
  lib,
  headless ? false,
  inputs,
  ...
}: {
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
      streamlink # Pipe streams into a video player
      pavucontrol # Control audio sources/sinks
      spek # Audio inspector
    ]);
}

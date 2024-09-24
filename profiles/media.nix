{
  pkgs,
  lib,
  headless,
  ...
}: {
  nixpkgs.config.pulseaudio = true;

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
  };

  environment.systemPackages = with pkgs;
    [
      yt-dlp
      flac
      sox
      ffmpeg
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      spotify
      vlc
      mpv
      kid3
      playerctl
      pavucontrol
      spek
      transmission_4-gtk
      pulseaudio
    ]);
}

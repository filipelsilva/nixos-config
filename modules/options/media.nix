{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Video/Audio management
    vlc
    mpv
    clementine
    yt-dlp
    flac
    sox
    ffmpeg
    handbrake
    kid3
    playerctl
    obs-studio
    spotify
    streamlink # Pipe streams into a video player
    pavucontrol # Control audio sources/sinks
    spek # Audio inspector

    # Image management
    sxiv
    feh
    gthumb
    exiftool
    imagemagick
    gimp
    krita
    inkscape
    mediainfo
    maim # Screenshot utility
    guvcview # Camera
    gpick # Color picker
    mypaint # Drawing table

    # Torrent management
    transmission
    transmission-gtk

    # OCR
    tesseract
  ];
}

{
  pkgs,
  lib,
  headless,
  ...
}: {
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  nixpkgs.config.pulseaudio = true;

  services.deluge = {
    enable = true;
    web.enable = true;
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
    ]);
}

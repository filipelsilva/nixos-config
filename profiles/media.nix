{
  pkgs,
  lib,
  headless,
  ...
}: {
  userConfig.extraGroups = ["audio"];

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  nixpkgs.config.pulseaudio = true;

  services.transmission.enable = true;

  environment.systemPackages = with pkgs;
    [
      yt-dlp
      flac
      sox
      ffmpeg
      transmission_4
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
    ]);
}

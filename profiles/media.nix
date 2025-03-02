{
  config,
  pkgs,
  lib,
  headless,
  dataPool,
  user,
  ...
}: {
  nixpkgs.config.pulseaudio = true;

  services.transmission = {
    enable = true;
    openRPCPort = true;
    inherit user;
    group = user;
    settings =
      {}
      // lib.attrsets.optionalAttrs (config.networking.hostName == "N100") {
        incomplete-dir-enabled = true;
        incomplete-dir = "${dataPool.location}/torrents/.incomplete";
        download-dir = "${dataPool.location}/torrents/Downloads";
        rpc-bind-address = "0.0.0.0";
      };
    package = pkgs.transmission_4;
  };

  systemd.services.transmission.serviceConfig.BindPaths = ["${dataPool.location}/torrents"];

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

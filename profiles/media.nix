{
  pkgs,
  lib,
  headless,
  user,
  ...
} @ inputs: let
  hasDataPool = builtins.hasAttr "dataPool" inputs;
  dataPool =
    if hasDataPool
    then inputs.dataPool
    else {};
in {
  nixpkgs.config.pulseaudio = true;

  services.transmission = {
    enable = true;
    inherit user;
    group = user;
    openRPCPort = hasDataPool;
    settings = lib.attrsets.optionalAttrs hasDataPool {
      incomplete-dir-enabled = true;
      incomplete-dir = "${dataPool.location}/torrents/.incomplete";
      download-dir = "${dataPool.location}/torrents/Downloads";
      rpc-bind-address = "0.0.0.0";
    };
    package = pkgs.transmission_4;
  };

  systemd.services.transmission.serviceConfig.BindPaths = lib.lists.optionals hasDataPool ["${dataPool.location}/torrents"];

  environment.systemPackages = with pkgs;
    [
      yt-dlp
      flac
      sox
      ffmpeg
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      spotify
      tidal-hifi
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

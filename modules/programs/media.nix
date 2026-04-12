{ pkgs, lib, ... }:
{
  flake.modules.nixos.programs_media =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (config.custom) headless domain;
      vhost = "${config.networking.hostName}.${domain}";
      hasDataPool = config.custom.dataPool != null;
      dataPool = config.custom.dataPool or { };
    in
    {
      nixpkgs.config.pulseaudio = true;

      services.transmission = {
        enable = true;
        user = "transmission";
        group = "transmission";
        openRPCPort = hasDataPool;
        settings = lib.attrsets.optionalAttrs hasDataPool {
          incomplete-dir-enabled = true;
          incomplete-dir = "${dataPool.location}/torrents/.incomplete";
          download-dir = "${dataPool.location}/torrents/Downloads";
          rpc-bind-address = "0.0.0.0";
        };
        package = pkgs.transmission_4;
      };

      users.users.transmission.extraGroups = [ "media" ];

      systemd.services.transmission.serviceConfig.BindPaths = lib.lists.optionals hasDataPool [
        "${dataPool.location}/torrents"
      ];

      programs.obs-studio.enable = true;

      environment.systemPackages =
        with pkgs;
        [
          yt-dlp
          flac
          sox
          ffmpeg
        ]
        ++ lib.lists.optionals (!headless) (
          with pkgs;
          [
            tidal-hifi
            vlc
            mpv
            kid3
            playerctl
            pavucontrol
            spek
            transmission_4-gtk
            pulseaudio
          ]
        );

      services.nginx.virtualHosts."${vhost}" = lib.mkIf config.services.nginx.enable {
        locations."/transmission" = lib.mkIf config.services.transmission.openRPCPort {
          proxyPass = "http://localhost:9091";
          extraConfig = ''
            proxy_pass_header  X-Transmission-Session-Id;
            client_max_body_size 50000M;
          '';
        };
        locations."/transmission/rpc" = lib.mkIf config.services.transmission.openRPCPort {
          proxyPass = "http://localhost:9091";
          extraConfig = ''
            proxy_pass_header  X-Transmission-Session-Id;
            client_max_body_size 50000M;
          '';
        };
      };
    };
}

{ ... }:
{
  flake.modules.nixos.services_jellyfin =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      services.jellyfin = {
        enable = true;
        user = "jellyfin";
        group = "jellyfin";
      };

      users.users.jellyfin.extraGroups = [ "media" ];

      environment.systemPackages = with pkgs; [
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
      ];

      services.nginx.virtualHosts."media.${config.custom.domain}" =
        lib.mkIf config.services.nginx.enable
          {
            forceSSL = true;
            useACMEHost = config.custom.domain;
            locations."/" = {
              proxyPass = "http://localhost:8096";
              extraConfig = ''
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Protocol $scheme;
                proxy_set_header X-Forwarded-Host $http_host;

                # Disable buffering when the nginx proxy gets very resource heavy upon streaming
                proxy_buffering off;
              '';
            };
            locations."/socket" = {
              proxyPass = "http://localhost:8096";
              extraConfig = ''
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Protocol $scheme;
                proxy_set_header X-Forwarded-Host $http_host;
              '';
            };
            extraConfig = ''
              ## The default `client_max_body_size` is 1M, this might not be enough for some posters, etc.
              client_max_body_size 20M;

              # Uncomment next line to Disable TLS 1.0 and 1.1 (Might break older devices)
              ssl_protocols TLSv1.3 TLSv1.2;

              # Security / XSS Mitigation Headers
              add_header X-Frame-Options "SAMEORIGIN";
              add_header X-XSS-Protection "0";
              add_header X-Content-Type-Options "nosniff";

              # Permissions policy. May cause issues with some clients
              add_header Permissions-Policy "accelerometer=(), ambient-light-sensor=(), battery=(), bluetooth=(), camera=(), clipboard-read=(), display-capture=(), document-domain=(), encrypted-media=(), gamepad=(), geolocation=(), gyroscope=(), hid=(), idle-detection=(), interest-cohort=(), keyboard-map=(), local-fonts=(), magnetometer=(), microphone=(), payment=(), publickey-credentials-get=(), serial=(), sync-xhr=(), usb=(), xr-spatial-tracking=()" always;

              # Content Security Policy
              add_header Content-Security-Policy "default-src https: data: blob: ; img-src 'self' https://* ; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' https://www.gstatic.com https://www.youtube.com blob:; worker-src 'self' blob:; connect-src 'self'; object-src 'none'; frame-ancestors 'self'";
            '';
          };
    };
}

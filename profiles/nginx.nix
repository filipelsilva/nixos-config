{
  inputs,
  config,
  lib,
  ...
}: let
  domain = "filipelsilva.net";
in {
  networking.firewall.allowedTCPPorts = [80 443];

  age.secrets."cloudflare-dns-api-token".file = "${inputs.self.outPath}/secrets/cloudflare-dns-api-token.age";

  security.acme = {
    acceptTerms = true;
    # TODO use email routing from cloudflare
    defaults.email = "w6hfznkvb@mozmail.com";
    defaults.webroot = null;
    certs = {
      "${domain}" = {
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        credentialFiles = {
          "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.age.secrets."cloudflare-dns-api-token".path;
        };
        dnsPropagationCheck = true;
        domain = "${domain}";
        extraDomainNames = ["*.${domain}"];
        reloadServices = ["nginx"];
        webroot = null;
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."${config.networking.hostName}.${domain}" = {
      forceSSL = true;
      useACMEHost = domain;
      locations."/monitoring" = lib.attrsets.optionalAttrs (config.modules.monitoring.enable) {
        proxyPass = "http://localhost:${builtins.toString config.modules.monitoring.port}/";
      };
      locations."/files/" = lib.attrsets.optionalAttrs (config.services.copyparty.enable) {
        proxyPass = "http://localhost:3923/files/";
        extraConfig = ''
          proxy_redirect off;
          # disable buffering (next 4 lines)
          proxy_http_version 1.1;
          client_max_body_size 0;
          proxy_buffering off;
          proxy_request_buffering off;
          # improve download speed from 600 to 1500 MiB/s
          proxy_buffers 32 8k;
          proxy_buffer_size 16k;
          proxy_busy_buffers_size 24k;

          proxy_set_header   Connection        "Keep-Alive";
          proxy_set_header   Host              $host;
          proxy_set_header   X-Real-IP         $remote_addr;
          proxy_set_header   X-Forwarded-Proto $scheme;
          proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
        '';
      };
      locations."/transmission" = lib.attrsets.optionalAttrs (config.services.transmission.openRPCPort) {
        proxyPass = "http://localhost:9091";
        extraConfig = ''
          proxy_pass_header  X-Transmission-Session-Id;
          client_max_body_size 50000M;
        '';
      };
      locations."/transmission/rpc" = lib.attrsets.optionalAttrs (config.services.transmission.openRPCPort) {
        proxyPass = "http://localhost:9091";
        extraConfig = ''
          proxy_pass_header  X-Transmission-Session-Id;
          client_max_body_size 50000M;
        '';
      };
      extraConfig = ''
        # From copyparty: https://github.com/9001/copyparty/blob/hovudstraum/contrib/nginx/copyparty.conf
        client_max_body_size 50000M;
        client_header_timeout 610m;
        client_body_timeout 610m;
        send_timeout 610m;
      '';
    };
    virtualHosts."${domain}" = {
      forceSSL = true;
      enableACME = true;
    };
    # virtualHosts."photos.${domain}" = lib.attrsets.optionalAttrs (config.services.immich.enable) {
    virtualHosts."photos.${domain}" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:2283";
        # proxyPass = "http://localhost:${builtins.toString config.services.immich.port}/";
        extraConfig = ''
          # allow large file uploads
          client_max_body_size 50000M;

          # Set headers
          proxy_set_header Host              $host;
          proxy_set_header X-Real-IP         $remote_addr;
          proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;

          # enable websockets: http://nginx.org/en/docs/http/websocket.html
          proxy_http_version 1.1;
          proxy_set_header   Upgrade    $http_upgrade;
          proxy_set_header   Connection "upgrade";
          proxy_redirect     off;

          # set timeout
          proxy_read_timeout 600s;
          proxy_send_timeout 600s;
          send_timeout       600s;
        '';
      };
    };
    virtualHosts."media.${domain}" = lib.attrsets.optionalAttrs (config.services.jellyfin.enable) {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8096";
        extraConfig = ''
          # proxy_set_header Host $host;
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
          # proxy_set_header Host $host;
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
        # NOTE: X-Frame-Options may cause issues with the webOS app
        add_header X-Frame-Options "SAMEORIGIN";
        add_header X-XSS-Protection "0"; # Do NOT enable. This is obsolete/dangerous
        add_header X-Content-Type-Options "nosniff";

        # Permissions policy. May cause issues with some clients
        add_header Permissions-Policy "accelerometer=(), ambient-light-sensor=(), battery=(), bluetooth=(), camera=(), clipboard-read=(), display-capture=(), document-domain=(), encrypted-media=(), gamepad=(), geolocation=(), gyroscope=(), hid=(), idle-detection=(), interest-cohort=(), keyboard-map=(), local-fonts=(), magnetometer=(), microphone=(), payment=(), publickey-credentials-get=(), serial=(), sync-xhr=(), usb=(), xr-spatial-tracking=()" always;

        # Content Security Policy
        # See: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
        # Enforces https content and restricts JS/CSS to origin
        # External Javascript (such as cast_sender.js for Chromecast) must be whitelisted.
        # NOTE: The default CSP headers may cause issues with the webOS app
        add_header Content-Security-Policy "default-src https: data: blob: ; img-src 'self' https://* ; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' https://www.gstatic.com https://www.youtube.com blob:; worker-src 'self' blob:; connect-src 'self'; object-src 'none'; frame-ancestors 'self'";
      '';
    };
  };
}

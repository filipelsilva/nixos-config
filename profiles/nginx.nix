{
  config,
  lib,
  ...
}: let
  domain = "filipelsilva.net";
in {
  networking.firewall.allowedTCPPorts = [80 443];

  age.secrets."cloudflare-dns-api-token".file = ../secrets/cloudflare-dns-api-token.age;

  security.acme = {
    acceptTerms = true;
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
    virtualHosts."${config.networking.hostName}.${domain}" = let
      wgSubnet = config.modules.wireguard.subnet;
      wgLastOctet = builtins.toString config.modules.wireguard.lastOctet;
      currentWireguardIP = "${wgSubnet}.${wgLastOctet}";
    in {
      forceSSL = true;
      useACMEHost = domain;
      listen = [
        {
          addr = currentWireguardIP;
          port = 80;
        }
        {
          addr = currentWireguardIP;
          port = 443;
          ssl = true;
        }
        # Public IP - For public access (needed for ACME and SSL)
        # {
        #   addr = "0.0.0.0"; # Or use specific public IP if you prefer
        #   port = 80;
        # }
        # {
        #   addr = "0.0.0.0"; # Or use specific public IP if you prefer
        #   port = 443;
        #   ssl = true;
        # }
      ];
      locations."/monitoring" = lib.attrsets.optionalAttrs (config.modules.monitoring.enable) {
        proxyPass = "http://localhost:${builtins.toString config.modules.monitoring.port}/";
        extraConfig = ''
          allow ${wgSubnet}.0/24;
          deny all;
        '';
      };
      locations."/files/" = lib.attrsets.optionalAttrs (config.modules.file-server.enable) {
        proxyPass = "http://localhost:${builtins.toString config.modules.file-server.port}";
        extraConfig = ''
          allow ${wgSubnet}.0/24;
          deny all;
        '';
      };
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

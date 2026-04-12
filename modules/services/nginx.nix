{
  inputs,
  config,
  lib,
  ...
}:
let
  domain = "filipelsilva.net";
in
{
  flake.modules.nixos.services_nginx =
    {
      inputs,
      config,
      lib,
      ...
    }:
    let
      inherit (config.custom) domain;
    in
    {
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      age.secrets."cloudflare-dns-api-token".file =
        "${inputs.self.outPath}/secrets/cloudflare-dns-api-token.age";

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
            extraDomainNames = [ "*.${domain}" ];
            reloadServices = [ "nginx" ];
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
        virtualHosts."photos.${domain}" = {
          forceSSL = true;
          useACMEHost = domain;
          locations."/" = {
            proxyPass = "http://localhost:2283";
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
      };
    };
}

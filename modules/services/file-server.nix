{ inputs, ... }:
{
  flake.modules.nixos.services_file-server =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    let
      dataPool = config.custom.dataPool;
    in
    {
      imports = [
        inputs.copyparty.nixosModules.default
      ];

      services.copyparty = {
        enable = true;
        user = "copyparty";
        group = "copyparty";
        settings = {
          rp-loc = "/files";
        };
        volumes = {
          "/" = {
            path = dataPool.location;
            access = {
              r = "*";
              rw = "*";
            };
          };
        };
      };

      users.users.copyparty.extraGroups = [ "media" ];

      environment.systemPackages = with pkgs; [
        copyparty
      ];

      services.nginx.virtualHosts."${config.networking.hostName}.${config.custom.domain}" =
        lib.mkIf config.services.nginx.enable
          {
            locations."/files/" = lib.mkIf config.services.copyparty.enable {
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
          };
    };
}

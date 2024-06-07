{
  config,
  pkgs,
  ...
}: {
  networking = {
    firewall = {
      enable = true;
      # allowedTCPPorts = [80 443 ];
      extraCommands = "";
    };
  };

  environment.etc."nextcloud-admin-pass".text = "123456789012345";

  services = {
    nextcloud = {
      enable = false;
      package = pkgs.nextcloud29;

      https = true;
      hostName = "localhost";

      config.adminpassFile = "/etc/nextcloud-admin-pass";

      database.createLocally = true;
      configureRedis = true;

      maxUploadSize = "16G";

      autoUpdateApps = {
        enable = true;
        startAt = "06:00";
      };

      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit calendar contacts tasks;
      };

      settings = {
        overwriteprotocol = "https";
        default_phone_region = "PT";
        trusted_domains = [ "*" "192.168.1.70" ];
        enabledPreviewProviders = [
          "OC\\Preview\\BMP"
          "OC\\Preview\\GIF"
          "OC\\Preview\\JPEG"
          "OC\\Preview\\Krita"
          "OC\\Preview\\MarkDown"
          "OC\\Preview\\MP3"
          "OC\\Preview\\OpenDocument"
          "OC\\Preview\\PNG"
          "OC\\Preview\\TXT"
          "OC\\Preview\\XBitmap"
          "OC\\Preview\\HEIC"
        ];
      };
    };
  };
}

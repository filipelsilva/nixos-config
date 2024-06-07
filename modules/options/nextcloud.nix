{
  config,
  pkgs,
  ...
}: {
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud28; # Need to manually increment with every update
      hostName = "cloud.pipinho";

      https = true;
      autoUpdateApps = {
        enable = true;
        startAt = "06:00";
      };

      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit calendar contacts tasks;
      };

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
      };

      database.createLocally = true;

      extraOptions.enabledPreviewProviders = [
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
}

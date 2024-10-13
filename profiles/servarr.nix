{...}: {
  services = {
    # Trackers
    prowlarr = {
      enable = true;
    };

    # Bypass CloudFlare protection
    flaresolverr = {
      enable = true;
    };

    radarr = {
      enable = true;
    };
    sonarr = {
      enable = true;
    };
    readarr = {
      enable = true;
    };
    lidarr = {
      enable = true;
    };
  };
}

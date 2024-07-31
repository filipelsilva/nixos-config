{...}: {
  services = {
    prowlarr.enable = false;
    lidarr = {
      enable = false;
      user = "filipe";
      group = "filipe";
      dataDir = "/home/filipe/.config/lidarr";
    };
  };
}

{...}: {
  services.syncthing = {
    enable = true;
    user = "filipe";
    group = "filipe";
    dataDir = "/home/filipe/.syncthing";
  };
}

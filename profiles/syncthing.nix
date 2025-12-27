{...}: {
  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/home/filipe/.syncthing";
  };

  users.users.syncthing.extraGroups = ["media"];
  userConfig.extraGroups = ["media"];
}

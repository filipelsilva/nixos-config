{...}: {
  userConfig.extraGroups = ["vboxusers"];

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = false;
    };
  };
}

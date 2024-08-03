{
  config,
  pkgs,
  lib,
  user,
  userFullName,
  ...
}:
with lib; {
  imports = [
    (mkAliasOptionModule ["homeConfig"] ["home-manager" "users" "${user}"])
    (mkAliasOptionModule ["userConfig"] ["users" "users" "${user}"])
  ];

  users.groups.${user} = {};
  userConfig = {
    isNormalUser = true;
    initialPassword = "password";
    shell = pkgs.zsh;
    description = userFullName;
    group = user;
    extraGroups = [
      "audio"
      "docker"
      "dialout"
      "libvirtd"
      "networkmanager"
      "storage"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  homeConfig = {
    home.username = user;
    home.homeDirectory = "/home/${user}";
    home.stateVersion = config.system.stateVersion;
    programs.home-manager.enable = true;
  };
}

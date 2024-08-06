{
  config,
  pkgs,
  lib,
  user,
  userFullName,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule ["homeConfig"] ["home-manager" "users" "${user}"])
    (lib.mkAliasOptionModule ["userConfig"] ["users" "users" "${user}"])
  ];

  users.groups.${user} = {};
  userConfig = {
    isNormalUser = true;
    initialPassword = "password";
    shell = pkgs.zsh;
    description = userFullName;
    group = user;
    extraGroups = ["wheel"];
  };

  homeConfig = {
    home.username = user;
    home.homeDirectory = "/home/${user}";
    home.stateVersion = config.system.stateVersion;
    programs.home-manager.enable = true;
  };
}
